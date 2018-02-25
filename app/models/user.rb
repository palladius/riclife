require 'digest/sha1'

class User < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  ### riccardo BEGIN
  # User.person_id
  belongs_to :person  
  # TODO add to DB with proper migration..
#  enum role: {
#    normal: 0, # default
#    admin:  1,
#    root:   2
#  }
  ## RICCARDO_END

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation

  acts_as_state_machine :initial => :pending
  state :passive
  state :pending, :enter => :make_activation_code
  state :active,  :enter => :do_activate
  state :suspended
  state :deleted, :enter => :do_delete

  event :register do
    transitions :from => :passive, :to => :pending, :guard => Proc.new {|u| !(u.crypted_password.blank? && u.password.blank?) }
  end
  
  event :activate do
    transitions :from => :pending, :to => :active 
  end
  
  event :suspend do
    transitions :from => [:passive, :pending, :active], :to => :suspended
  end
  
  event :delete do
    transitions :from => [:passive, :pending, :active, :suspended], :to => :deleted
  end

  event :unsuspend do
    transitions :from => :suspended, :to => :active,  :guard => Proc.new {|u| !u.activated_at.blank? }
    transitions :from => :suspended, :to => :pending, :guard => Proc.new {|u| !u.activation_code.blank? }
    transitions :from => :suspended, :to => :passive
  end


    # NON VA
  # def set_password_riccardo(newpwd)
  #     password=newpwd
  #     password_confirmation=newpwd
  #     save
  #   end
  def to_s
    login
  end
  
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_in_state :first, :active, :conditions => {:login => login} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  # RICCARDO: dflt sys user... assert that it exists :)
  def self.default_system_user
    User.find_by_login('riclife')
  end

  def self.names
    map{|u| u.name }
  end

  def before_create
    if Person.find_by_nickname(login)
      errors.add("Cant create this user, a person already exists with this name: '#{login}'!")
      return false
    end
    return true
  end

  def name_and_email()
    "#{login} <#{email}>"
  end

  # popola con calendari e cagate varie
  def after_create()
    puts "T40 Ric after crea creo calendari personali.."
    # dovrei farlo transazionale...
    #role = 0
    ### IMPORTANTE TBD_IMP
    # TBD verifica se esiste già uno con quella email!! Se no fallisce
    my_person = Person.create(
         :name     => login, 
         :surname  => 'AutoCreated', 
         :nickname => login, 
         :email    => email, 
         :tags     => 'virtual auto_created tmp person bot auto',
         :virtual  =>  true,
         :notes    => "Creato causa login di user #{id} e mancava il suo personaggio, ed eccomi qui.."
    )
    #my_person = Person.find_by_nickname(login) # dovrebbe essere creato dal before_create..
    #my_person = Person.find_or_create_by_nickname!(login) #, :mail =>     email, :notes => "'Just created user #{id}..'" )
    #my_person.save
    self.person_id = my_person.id
    self.person = my_person
    #self.save!
    pers = Calendar.create( 
      :name => "#{login} Personal Calendar", 
      :person_id => my_person.id, 
      :private => true ) rescue "couldnt create it, amen.."
    send_gms("Welcome '#{login}' to RicLife. Read the docs before disturbing pliz",'PS No docs have been written, though... :P')
    Gms.send_all("Everybody say hello to new user: #{login}!")
    #Calendar.create( :name => 'Public stuff', :user_id => self.id, :private => false )
  end

 def to_s
   login
 end
 alias :name :to_s

 def to_label
#‘’   login.capitalize rescue 'boh'
   login.to_s.capitalize rescue 'boh'
 end
 
 def venue
   person.venue rescue nil
 end
 
 def send_gms(subject,body='')
   Gms.create( :subject => subject,:body => body , :to_id => self.id)
 end
 
 def feed
   person.feed
 end
 def nickname 
   login
 end
 alias :feed2    :feed
 alias :name     :nickname

 def is_admin?
   return login == 'riclife'
 end
 alias :is_root?    :is_admin?

 
 # def person
 #   Person.find(7)
 # end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    def make_activation_code
      self.deleted_at = nil
      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
    
    def do_delete
      self.deleted_at = Time.now.utc
    end

    def do_activate
      @activated = true
      self.activated_at = Time.now.utc
      self.deleted_at = self.activation_code = nil
    end
end
