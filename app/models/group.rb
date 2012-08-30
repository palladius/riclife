class Group < ActiveRecord::Base

  belongs_to :person

  searchable_by :name
  validates_uniqueness_of :name

  def to_s
    name
  end

end
