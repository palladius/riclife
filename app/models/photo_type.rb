class PhotoType < ActiveRecord::Base
  has_one :photo, :dependent => :destroy
  
  searchable_by :name, :description

  def to_label
    name
  end

  def to_s
    name
  end

  #alias :to_label :to_s

end
