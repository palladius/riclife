class Gms < ActiveRecord::Base
  
  searchable_by :subject, :body  
  acts_as_commentable

  validates_presence_of :to
  validates_presence_of  :body # checcacchio, almeno un carattere, scrivimi qualcosa!
  belongs_to :from, :foreign_key => 'from_id' , :class_name => 'User'
  belongs_to :to,   :foreign_key => 'to_id' ,   :class_name => 'User'
  
  def self.send_all(subject,body='no body')
    User.find(:all).each{ |u| 
      u.send_gms(subject,body)
    }
  end
  
  def to_s
    subject
  end
  alias :name :to_s
  
  #  def before_validation_on_create() sarebbe piu appropriato...
  def before_validation()
    logger.debug "Vediamo di mettere mittente a riclife se non c'e'.."
    self.from = User.default_system_user unless attribute_present?("from_id") # unless User.find_by_login('riclife') unless 
  end
  
  def set_as_read
    #@gms.unread=false
    #@gms.save
    self.unread = false
    self.save
  end
  
end
