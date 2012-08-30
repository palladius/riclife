
# $Id: venues_helper.rb 1570 2010-06-27 11:42:13Z riccardo $
#
# scupiazzato da:
#  http://www.tomschlenkhoff.com/2008/10/geokit-on-rails-212-works-nicely-test-the-installation/
#  http://geokit.rubyforge.org/api/index.html
#  http://geokit.rubyforge.org/readme.html
# Guarda se c'e' di meglio da fare, tipo bufferizzare la doistanza o computarla in locale (ora su N venues
# fa N query a ogni index view!)

module VenuesHelper

  DFLT_ZOOM = 13 # 11 è alto, 13 è piu a bassa quota, con 17 sei piu preciso, tipo a occhio:
    # 17 casa nostra
    # 12 Dublino centro
    # 10 Dublino esteso
 
  include GeoKit::Geocoders

  # calcolala al login..
  #PARTENZA = MultiGeocoder.geocode('Beresford St, Dublin, Ireland')

  def name_column(r)
		if r.class.to_s == 'Venue'
			"<b class='venue' >#{ link_to r.name, r }</b> <em>" + link_to( (r.address ), "http://maps.google.com/maps?sll=#{r.lat},#{r.lng}", :target => '_blank' ) rescue "Unknown address for Venue" + "</em>"
		else
			"<b>ERRORE di tipo incasinato 2183 :) #{ r.class }<>Venue! </b>" # questa funzione è chiamata da un altro controller:
		end
  end
  
  def tags_column(r)
    "<span class='tags>" + (r.tags rescue '-' )+"</span>"
   # "TAGS TBD(#{t.tags rescue 'BOH'})"
  end
  
  alias :venue_type_column :tags_column 
  alias :vote_column :tags_column 
  alias :your_distance_column :tags_column 
  alias :venue_type_column :tags_column 

  def your_distance_column(r)
    #"P(#{r.coordinates}) - <br/> G(#{r.dflt_coordinates}) = <br/> #{r.your_distance}"
    #home = MultiGeocoder.geocode(r.address)
    #dist_miglia = home.distance_to(PARTENZA, :units => :kms )
    spanno_distance = (r.your_distance * 25000).to_i * 10 # lo taglio ai 10 metri
    return (spanno_distance > 1000) ?
     "#{spanno_distance/1000} km*" : # kmeters 
     "#{spanno_distance} m*"   # meters
  end

  def distance2(r)
     "#{dist_miglia * 1000} BeresfordKMs"
  end

  # obsolendo, vorrei tutti gli icon_path a implementare un icon_magic
  #def icon_column(r)
  #  icon_path_column(r)
  #end
  #   # questo sembra aver senso solo per le app..
  def url_column(r)
  #   link_to( app_column(r), r.build_link, :target => '_blank') rescue "Link error: #{$!}"
    link_to( r.url, r.url, :target => '_blank') rescue "Link error: #{$!}"
  end
  
  def gmap_column(r)
    link_to('Google', "http://maps.google.com/?ie=UTF8&ll=#{r.lat},#{r.lng}&z=#{DFLT_ZOOM}", :target => '_new' ) + ' ' +
      link_to('here', "/venues/gmap_show/#{r.id}", :target => '_new' )     
  end
  
  def app_column(r)
    44011
  end
  
  def venue_type_column(r)
    link_to(r.venue_type , r.venue_type) rescue "Err: #{$!}"
  end

end


#    	National Aquatic Centre, Snugborough Road, Abbotstown, Dublin 15

