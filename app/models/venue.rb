
class Venue < ActiveRecord::Base
  validates_presence_of :lat, :lng
  include GeoKit::Mappable
  
  acts_as_mappable :auto_geocode => true, :default_units => :kms, :default_formula => :flat
  #acts_as_voteable
  acts_as_commentable
  

  searchable_by :name, :description
  validates_presence_of :address
  validates_uniqueness_of :address, :name
  
  belongs_to :venue_type
  
  #has_many :people
     
# inutle perche c'è il geocode true!
    #before_validation_on_create :geocode_address
    #before_validation_on_update :geocode_address
    before_validation :geocode_address
    #before_validation :autocomplete_dflt_values # rinominato in before validation
  
  #private
  #def geocode_address geo = GeoKit::Geocoders::MultiGeocoder.geocode(address) errors.add(:address, "Could not geocode address") unless geo.success self.lat, self.lng = geo.lat, geo.lng if geo.success
  #end end

  def coordinates
    [ lat, lng ] rescue [42,42]
  end

  def gmaps_info_window
   "<a href='/venues/#{id}'><b>#{name}</b></a>: " + 
    " <img src='#{icon_path}' height='70' valign='top' align='right' /> "+ 
    "<i>#{address}</i> <hr/> <pre>#{description }</pre> " +
    "<a href='/venues/#{id}/edit'>EDIT</a>"
  end

  def distance_from(venue2)
     Venue.distance_between(self, venue2)
  end

  def self.distance(x1,y1,x2,y2)
    Math.sqrt( (x1.to_f - x2.to_f )**2 + (y1.to_f - y1.to_f )**2 ).to_f
  end

  # Quanto sono dry!!!
  def distance_arr(p1,p2 = coordinates )
    Venue.distance( p1[0],p1[1],p2[0],p2[1])
  end

  # da chi fare la distanza...
  # dovrei farlo con current_user :() TBD
#  def self.dflt_coordinates(person = nil)
  def dflt_coordinates(person = nil)
    person ||= current_user || 
      Person.find_by_name_and_surname('Fabio','Mattei') ||
      Person.find(:last) # giusto per farlo sbagliato...
    person.venue.coordinates
  end

    # distance of this venue from user's house
  def your_distance
    #distance_arr(self.dflt_coordinates )
    distance_arr(dflt_coordinates ) rescue 42
  end

  def fancy
    "<span class='event'>ICON_EVENTO #{link_to self.to_s,self}</span>" rescue "'erore' #{to_s}"
  end

  def to_s
    name
  end

    # I have to add something based on ID to make the icons not to overlapp exactly making all invisible after the first :)
  def fuzzied_coordinates
    #radix = 15 # sotto vado a dx, sopra vado in alto...
    offset = id / 10000.0 # dovrei fare 100m di delta...
    [lat+offset,lng+offset]
  end

    # put sensati values
  def before_validation
    self.name = "#{address} [AUTO]" unless attribute_present?("name")  
    self.private = false unless attribute_present?("private")  
    self.venue_type = (VenueType.find_by_name('Generic Location') rescue nil ) unless attribute_present?("venue_type_id") # starred: no
    return true
  end

  def geocode_address
    unless lat.nil? && lng.nil?
      puts("T40 No need for updating the geocode :)".green )
      return
    else
      puts("T40 Ricalcoliamolo mo'..".yellow() )
    end
    geo = GeoKit::Geocoders::MultiGeocoder.geocode(address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

# def gmaps_marker()
#   GMarker.new( coordinates, 
#     :title => name,
#     :info_window => gmaps_info_window
#   )
# end
  # 
  # ######################################################
  # # GoogleMap stuff
  # def add_to_map(map) # maybe a pointer??
  #   venue=self
  #   map.icon_global_init(venue.gmaps_icon, "icon_#{venue.id}" )
  #   map.overlay_init(
  #     GMarker.new( venue.coordinates, 
  #         :title => venue.name,
  #         :icon => Variable.new("icon_#{venue.id}"),
  #         :info_window => venue.gmaps_info_window
  #       )
  #    )
  # end
  #   # zoom = 0..17 (min..max)
  # def center_map( map , zoom = 12) 
  #   map.center_zoom_init( self.coordinates , zoom )
  # end
  # ######################################################

end

