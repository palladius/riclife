class Recipe < ActiveRecord::Base
  searchable_by :name

  def to_s
    name
  end
end
