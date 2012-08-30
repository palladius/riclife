module CountriesHelper
  
  def flag_column(r,height=15)
    image_tag("flags/flag_#{r.code.downcase}.png", :height => height, :label => "flag of #{r.name}")
  end
  
  def name_column(r)
    name = r.name rescue "CountryNameColumnErr: #{$!}"
    r.favourite ? name.bold : name
  end
  
end
