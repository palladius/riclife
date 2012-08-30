class Library < ActiveRecord::Base

  searchable_by :name

  def photo_path
    "42.jpg"
  end
  
end
