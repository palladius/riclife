class VenueType < ActiveRecord::Base

  searchable_by :name, :description

  # TBD active dflt to true
  
  def to_s
    name.capitalize
  end
  
  alias :to_label :to_s
end
