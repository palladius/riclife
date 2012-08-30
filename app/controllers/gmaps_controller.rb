class GmapsController < ApplicationController
  require 'ym4r'
  #caches_page :index
  
  # http://ym4r.rubyforge.org/ym4r_mapstraction-doc/
  def index
    @map = GMap.new("map_div")
    @map = gmap_create( "gmaps_map_div" )
    Venue.find(:all).each{|venue|
      add_venue_to_map(venue,@map)
      }
  end
  
  # mappa del solo posto..
  def show
    @venue = Venue.find(params[:id])
       @map = GMap.new("map_div")
       @map.control_init(:large_map => true,:map_type => true)
       dflt_venue = @venue
       @map.center_zoom_init( dflt_venue.coordinates , 16 )
       @map.icon_global_init(@venue.gmaps_icon, "icon_#{@venue.id}" )
       @map.overlay_init(
         GMarker.new( @venue.coordinates, 
             :title => @venue.name,
             :icon => Variable.new("icon_#{@venue.id}"),
             :info_window => @venue.gmaps_info_window
           )
        )
   end
  # http://google4r.rubyforge.org/api/google4r-maps/classes/Google4R/Maps/GIcon.html
  # http://juixe.com/techknow/index.php/2007/02/07/rails-google-maps-plugin/

end