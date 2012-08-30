=begin
  1 project with many tasks
=end

class Project < ActiveRecord::Base

  belongs_to :person
  acts_as_commentable # http://juixe.com/techknow/index.php/2006/06/18/acts-as-commentable-plugin/

  searchable_by :name, :description

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :person_id, :message => "Nome già scelto da questo utente"

#  named_scope :mine,   lambda { { :conditions => ['user_id = ?', current_user.id rescue 0 ] } }
  named_scope :by_person,     lambda { |*args| {:conditions => ["person_id = ?", (args.first.id || nil )]} }   # gli do un User
  named_scope :by_person_id,  lambda { |*args| {:conditions => ["person_id = ?", (args.first || nil )]} }  # gli do gia l id
  
  def to_s
    to_label
  end

#  def name
#    to_label
#  end

  def to_label()
    "[#{person.initials rescue '??' }] #{name.capitalize}"
  end

  def fancy()
    "<span class='project'>FANCY MODEL #{to_s} </span>"
  end

end
