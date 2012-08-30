# polymorphic, look here for a good answer:

# http://stackoverflow.com/questions/1443736/need-help-with-polymorphic-join-table-in-rails FA CACARE 
# meglio il libro di DHH :)


class Note < ActiveRecord::Base

  DESCRIPTION = 'Its a task a tutti gli effetti...'

  searchable_by :title , :description , :deadline
  
  validates_inclusion_of :progress,  :in => 0..100, :message => "is a task progress percentage (1..100)"
  validates_inclusion_of :relevance, :in => 0..30,  :message => "is a RELEVANCE (10/20/30) "
  validates_inclusion_of :relevance, :in => 0..30,  :message => "is a RELEVANCE (10/20/30) "
  validates_uniqueness_of :title, :message => "must be unique" # in futuro mettilo per utente magari...
  belongs_to :project

  def to_s
    #title
    overdue? ? "[OK] #{title}" : "#{title} (scaduta)"
  end

  def to_label
    overdue? ? "[OK] #{self}" : "#{self} (scaduta)"
  end

  def name
    title
  end
  
  def overdue?
    deadline < Time.now rescue false
  end
  
  def near_to_overdue?
    (deadline < Time.now + 30)  rescue true
  end
#  def published
#    "BUG vuole published in NOTE!! #{active}"
#  end

  def self.string_starting_with(str,ch)
     str.split.select{|x| x.match /^#{ch}/ }
   end

# class Note < ActiveRecord::Base
  def self.magic_create(one_line)
    ndays_deadline = 7 # scade tra 7 giorni
    str = one_line.strip()
    words = str.split()
    arr_desc = Array.new
    arr_desc << "Oroginal line: ''''#{str}''''\n"
    pluses = string_starting_with(words,'\+')
    ats = string_starting_with(words,'@')
    hashes = string_starting_with(words,'#')
    # devo capire il progetto dai tags
    mytags = pluses.join(', ') rescue 'niuno'    # simple 
    arr_desc << "Tags: #{mytags}\n"
    project = Project.last rescue nil # find_all_by_user(current_user)
    # tags = [ pluses,ats,hashes].join(', ').to_s,
  
    ret = Note.create( 
        :description => arr_desc.join("\n"),
        :tags => mytags,
        :title => str,
        :deadline =>  Date.today + 86400 * ndays_deadline ,
        :active => true,
        :project_id => project.id
        ).save
    puts "Ret: ''#{ret.inspect}''"    
  end #  Note.magic_create str
  
end
