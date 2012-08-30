class EventAttendee < ActiveRecord::Base
  
  belongs_to :event 
  belongs_to :person
  searchable_by :notes #, :person, :followed
  acts_as_commentable
 
  validates_presence_of :person , :event
  validates_uniqueness_of :person_id, :scope => :event_id
  
  def to_s
    [person.to_s , event.to_s ].join "@"
  end
  alias :to_label :to_s
  alias :name     :to_s
  
  def full_mail
    person.full_mail rescue "EvtAtde::FullMail exception: #{$!}"
  end
  
end
