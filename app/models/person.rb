class Person < ActiveRecord::Base
  #	has_many :notes, :as => :modello # modello e' parola scelta a caso, record un me piasceva
  @@description = <<-FINE
    Questa vuol essere banalmente la classe delle PERSONE tipo addressbook. Molto LDAP rubrichetta, diciamo.
    Anche se mi paicerebbe un'integrazione fica con mappe e indirizzi... vabbe vedremo'
    
    Diciamo che va visto come contatto. Penso che dovrei mettere unicita' su UTENTE+EMAIL, o meglio:
    per ogni utente puoi generare UNO e UN SOLO contatto con quell'email, che dobvra' essere verificato per fare networking :)
    
    Email la volevo mandatoria ma mi sembra davvero esagerato.
    Mette obbligatori NOME e COGNOME..
  FINE
  searchable_by :name, :organisation, :surname, :notes, :email, :mobile , :location, :nickname, :tags
  #acts_as_commentable #TBD
  #acts_as_carlesso

  ### riccardo BEGIN
  has_one :user
  ## RICCARDO_END

  validates_presence_of :name, :nickname, :surname # , :email 
  validates_inclusion_of :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :in => 3..18, :message => "Maccome non conosci i limiti di D&D???"
  validates_format_of :nickname, :with => /^[a-z_]+$/, :message  => " only lowercase chars and underscores (i.e. r_carlesso)"
  validates_format_of :email, :with => /^.+@.+$/, 
    :message  => " must be a valid email (fatto a manhause che chiede una sola chiocciolina.. correggimi!)",
    :allow_blank => true
  validates_format_of :relational_status, :with => /^(single|relationship|engaged|married|complicated|open_relationship|widowed)$/, 
    :message  => " must be valid: (single|relationship|engaged|married|complicated|open_relationship|widowed)",
    :allow_blank => true
  validates_uniqueness_of :nickname
  validates_uniqueness_of :email, :allow_nil => true, :allow_blank => true
  #validates_uniqueness_of :email #, :allow_nil => true, :allow_blank => true
  validates_inclusion_of :sexappeal,  :in => 5..100, :message => "Dammi un numero da 1 a 10 step 5 mooltiplicato per 10 insomma da 5 a 100. Grazie"
  validates_uniqueness_of :name, :scope => :surname, 
    :case_sensitive => false, # NON FUNZIONA!!
    :message => "Name+Surname are already taken! If its a homonym please contact our administrator.. There is a bug in CaseSensitive check so change some UPPER/lowercase and u should be grand ;-)"
  

  belongs_to :work_venue, :foreign_key => 'work_venue_id' , :class_name => 'Venue'
  belongs_to :venue # idem ma è default, sarebbe la HOME VENUE :)
  belongs_to :country # idem ma è default, sarebbe la HOME VENUE :)
  
  has_many :identities , :foreign_key => "person_id"    #, :dependent => true
  has_many :identities , :foreign_key => "followed_id"  #, :dependent => true
  
  has_many :apps, :through => :identities
  has_many :calendars 
  has_many :projects
  
  #has_many :followers, :through => :friendships
  #has_and_belongs_to_many :apps, :join_table => 'identities'

  named_scope :recent ,     lambda { { :conditions => ['updated_at < ?', Time.now - 2.week] } }
  named_scope :important,   lambda { { :conditions => ['relevance > ?', 35 ] } } # TBD or starred = true
  named_scope :interesting, lambda { { :conditions => ['relevance > ?', 25 ] } }  
  named_scope :active,      lambda { { :conditions => ['relevance > ? AND published = ?', 10 , true ] } }  
  named_scope :punizione,   lambda { { :conditions => ['relevance < ? OR published = ?', 11 , false ] } }  

  @@relationship_status_map = {
    :single             => 'Single',
    :relationship       => 'In a relationship',
    :engaged            => 'Engaged',
    :married            => 'married (sigh!)',
    :complicated        => "It's complicated",
    :open_relationship  => 'In an open relationship',
    :widowed            => 'Widowed',
    :nil                => 'n.a.'
  }

  def self.dnd_labels
    { 
      'str' => 'Str', 
      2 => 'Dex', 
      3 => 'Con', 
      4 => 'Int', 
      5 => 'Wis', 
      'cha' => 'Cha'
      }
  end
  
  def relational_status_description()
    begin
      my_status = (self.relational_status || 'nil' ) rescue "RelStatErr: '#{$!}'"
      #my_status = my_status.to_s
      my_status = 'nil' unless my_status.to_s.length > 1
      return @@relationship_status_map.fetch(my_status.to_sym, "Unknown Relational Status: '#{my_status}'")
    rescue
      return "'RSD::Some Err: '#{$!}'"
    end
  end
  
  def single?
    my_status.to_s.match /^(single|widowed)$/
  end
  
  def self.uninteresting_attributes
    %w{ strength charisma constitution dexterity intelligence published starred wisdom }
  end
  def self.quick_create(name,surname)
    Person.create(
      :name => name,
      :surname => surname,
      :nickname => "#{name}_#{surname}".nicknamize,
      :description => "Created with quick_create on #{Time.now}"
    ).save
  end
    
    # i.e. 'Kevin Dermody <iamginge@gmail.com>'
  def self.add_by_string(name_surname_email)
     m = name_surname_email.match(/^(\w+) (\w+) <(.*)>/)
     raise "Your string doesnt contain a NAME SURNAME <EMAIL> as expected (#{name_surname_email})!" unless m
     (name,surname,email) = m[1],m[2],m[3]
     p = Person.create :name => name, :surname => surname, :email => email, :tags => 'auto add_by_string' , :male => Person.sex_detect(name)
     puts p
     puts p.errors.map{|e| e.to_s }
     return p.save
  end
  
    # male is
    # o$
  def self.sex_detect(name)
    # italian names:
    #deb "Sex detect for name: #{name}"
    return true if name.match(/luca|andrea|o$/i)
    return false if name.match(/a$/i)
    return true # nel dubbio faccio maschio...
  end
  
  def gmaps_info_window
   return <<-SNIPPET_PERSON
      <a href='/people/#{id}'><h2>#{name}</h2></a>
    <img src='#{icon_path}' height='70' valign='top' align='right' /> 
    <small><a href='/venues/#{venue.id}'>#{venue.address || 'Address unknown' }</a></small> 
     <hr/> 
    #{ "<pre>#{notes}</pre>" if notes}
    #{"Tel: #{mobile}" if mobile}
    <a href='/people/#{id}/edit'>EDIT</a>
    SNIPPET_PERSON
  end
  
    # comes usually with trailing .jpg...
  def photo(if_not_found = "anonymous.jpg" )
     photo_name.nil? ? if_not_found : photo_name
  end
  
    # may have 
  def user
    User.find_by_person_id(self.id) rescue nil
  end
  
  def photo_path()
    "people/" + photo(name)
  end
  
  def icon_path
    "/images/" + photo_path
  end

  def to_s
    "#{name.capitalize} #{surname.capitalize}" || '(Unknown!!!)' rescue 'Person to_s error'
  end
		
	def to_label
    to_s
  end
  
  def dnd_attributes()
    [ strength, dexterity, intelligence, wisdom, constitution, charisma ]
  end
  
  def self.dnd_attributes
    %w{ strength dexterity intelligence wisdom constitution charisma  }
  end
  
  def initials
    [name || nil, surname || nil].map{|str| str.first }.join('') rescue "{W1?}"
  end
  
  def initials2
     [name , surname].map{|str| str.first }.join('') rescue "{W2?}"
  end
  
  def fancy
   "<span class='Person'>FANCY ICONCINA #{to_s} </span>"
   #link_to( self,self)
  end
  
  def age
    return nil unless defined?(birthday)
    ((Date.today - self.birthday) / 365).to_i rescue '' # "AgeErr: #{$!}"
  end

  def feed2
    str_feed = feed ? "''#{feed}''": '-'
    str_feed.tag('span', :class => 'feed') 
  end
  
  def name_surname
    "#{name.to_s.capitalize} #{surname.to_s.capitalize}" rescue "NameSurname ERR (#{$!})"
  end
  
  def surname_name
    "#{surname.to_s.capitalize}, #{name.to_s.capitalize}" #rescue "SurnameName ERR (#{$!})"
  end
  
  def abbreviated_name
    "#{name.to_s.capitalize} #{surname.to_s.capitalize[0..0]}" # Riccardo C.
  end
  
  def birthday? 
    birthday ? 
      (birthday < (Date.today << 60)) : # 60 months
      false
  end
  
  def dot_nickname 
    nick = nickname || _fake_nickname # rescue "NickErr: #{$!}"
    nickname.to_s.gsub(/[ \']/,'_') # dev essere downcase per la validation! aahahaha
  end
  
  def full_mail(comment = ' ')
    "#{name_surname}#{comment} <#{email}>"
  end
  
  def gender
    male ? 'male' : 'female'
  end
  def sex
    gender
  end
  
  def to_html(opts={})
    if opts[:abbreviated]
      return "<span class='person #{gender}'>#{abbreviated_name}</span>"
    else
      return "<span class='person #{gender}'>#{name_surname}</span>"
    end
  end
  
 # # Questo fa cacare, va molto melgio nel CONTROLLER!
 # def before_save #_RIPRISTINAMI_TODO
 #      begin
 #       puts "\n\n   Person::before_save: sto salvando una persona... DEBUG \n\n"
 #       str             = "\n[Person.before_save siccome mi lasci il feed vuoto DEBUG Last updated by: #{current_user rescue '_CURRENT_USER_BOH'} ]"
 #       self.created_by = current_user.id
 #       self.tags       ||= 'riclife'
 #     rescue
 #       logger.error "Person(#{id rescue 'boh' }).before_save() Riccardo error: #{$!}"
 #     end
 #     return true
 # end
  
  def _fake_nickname
    "#{name[0..0]}#{surname}".downcase
  end
  
  # mette alcuni valori a default...
  def before_validation() 
    #logger.info "Tend: #{tend} // class: #{tend.class}"
    self.published = true  unless attribute_present?("published")    # pubblicato: yes
    self.starred  = false  unless attribute_present?("starred")           # starred: no
    #ric_change_parameter('starred',false)
    #self.birthday = Date.civil(1901,1,1) unless attribute_present?("birthday")  # compleanno 1gen1901
    self.nickname = _fake_nickname unless attribute_present?("nickname") # i.e. 'rcarlesso'
    self.created_by ||= current_user.name rescue "ModelCreatedBy: #{$!}"
    self.updated_by   = current_user.name rescue "Probably Updated from shell and not from web: ''#{$!}''"
    if (attribute_present?("organisation")  && ! attribute_present?("work_venue_id") ) # --> autocreate workplace obj from string! Cool!
      self.work_venue = Venue.find_or_create_by_name(organisation.strip) rescue nil
    end
    if (attribute_present?("location")  && ! attribute_present?("venue_id") ) # --> autocreate workplace obj from string! Cool!
      self.venue = Venue.find_or_create_by_name(location.strip) rescue nil
    end
    self.relevance = 42 unless attribute_present?("relevance")     # rilevanza 42
    # NON HO ACCESSO AL CURRENTUSER DA QUI! SOLO VIEW E CONTROLLER!!!
    #self.feed = "Person:_:BeforeValidation(): person changed by ''#{@current_user rescue 'BOH'}'' on #{Time.now}" unless attribute_present?("feed") 
    #self.nickname = self.nickname.nicknamize rescue nil            # minuscolizza e toglie spazi
    self.email = self.email.strip if attribute_present?("email")
  end
  
  # filtra chi e' graficabile
  def graphable?
    #(self.name =~ /ricc|lag/i || self.virtual ) rescue false 
    (! self.virtual) rescue false # PRODUCTION
  end
  

 
  # 
#  def validate
#    errors.add(:name, "cant contain an a :)") if name.match /a/
#  end
  # 
  #   # TBD metti in Helper
  # def dot_key_values(hash)
  #   hash.map{|k,v| 
  #     "#{k}=\"#{ v.to_s.gsub(/"/, "''" ).gsub("\n",' ') }\"" 
  #   }.join(', ')
  # end
  # 
  # # rbellosi  [label="Ridge turing PNG", shape=box, color=black, image="web20/Turing.png" ];
  def to_dot
    dot_opts = {}
    tooltip = "Tags: #{tags rescue '-'} \n <br/> \nFeed: '#{feed rescue ''}'"
    
    # color = male ? 'blue' : 'pink'
    # color = 'gray' if virtual
    #return 'nisba1 [label="nisba2"];' if virtual
    #shape = 'star' if starred
#    bgcolor = 'star' if starred
    penwidth = 5 if starred
    dot_opts[:label] = name_surname
    dot_opts[:shape] = 'rectangle' #  'star' if starred 
    dot_opts[:penwidth] = penwidth rescue '1'
    dot_opts[:bgcolor] = 'yellow' if starred # 'white'
    dot_opts[:color] =  male ? 'blue' : 'pink'
    dot_opts[:color] = 'gray' if virtual
    #dot_opts[:URL] =    "mailto:#{email}"
    dot_opts[:URL] =    "/people/#{id}/edit"
    dot_opts[:target] =    "_new"
    dot_opts[:tooltip] =    tooltip
    dot_opts[:image] =  "public/images/people/#{nickname}.jpg" if File.exists?("/images/people/#{nickname}.jpg")
    dot_opts[:imagescale] =  true #{}"public/images/people/#{nickname}.jpg"
    #{}"#{nickname} [label=\"#{name_surname}\", shape=#{shape rescue 'box'}, penwidth=#{penwidth rescue '1'}, bgcolor=#{bgcolor rescue 'white'}, color=#{color rescue 'pink' }, URL=\"mailto:#{email}\", image=\"/public/images/people/\" ] ; "
    "#{nickname rescue name_surname } [" + dot_key_values(dot_opts) + "]" rescue "Person.to_dot(#{self}) Exception: #{$!}"
  end
  
end
