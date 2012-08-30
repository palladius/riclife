class Country < ActiveRecord::Base

  searchable_by :code, :name
   
  validates_uniqueness_of :code, :name
  validates_format_of      :code, :with => /^[A-Z][A-Z]$/, :message  => " must contain only TWO Uppercase alphabetic chars!"

  def to_s
    name
  end
end
