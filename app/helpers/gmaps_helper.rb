module GmapsHelper
  require 'ym4r'  
  include ApplicationHelper
  
  DEFAULT_ZOOM = 12

  def gmaps_gicon(icon_path = "/images/pizza.png", iconsize = 25)
    return GIcon.new(
       :image => (icon_path rescue "/images/pizza.png"),
       :shadow => "/images/pizza-shadow.png",
       :icon_size => GSize.new(iconsize,iconsize),
       :shadow_size => GSize.new(iconsize,iconsize),
       :icon_anchor => GPoint.new(7,7),
       :info_window_anchor => GPoint.new(9,2)
    ) 
  end
  
  def gmap_create(divname='unknown_map_div',venue=nil,zoom = DEFAULT_ZOOM)# "calendar"
    map = GMap.new("calendar_map_div")
    map.control_init(:large_map => true,:map_type => true)
    # TBD dflt venue= casa tua
    venue ||= Venue.find(:last)
    map.center_zoom_init( venue.coordinates , DEFAULT_ZOOM ) if venue # tant par tacher :) TBD      if venue
    return map
  end

  # non so se pèopolare due volote qui o se fare un'unica primitiva che accetti
  # dal padre se essere casa o lavoro.. per ora faccio un doppione qui inelegante finchè non scelgo..
  #def populate_map_with_person(map,person, icon = nil)
  def add_person_to_map(person,map, icon = nil)
    if person.venue
      map.icon_global_init( gmaps_gicon(person.icon_path,25), "person_#{person.id}_home" ) # person.icon_path
      map.overlay_init(
        GMarker.new( person.venue.fuzzied_coordinates, 
            :title => "#{person.name} (home)",
            :icon => Variable.new("person_#{person.id}_home"),
            :info_window => person.gmaps_info_window
          )
       )
     end
     if person.work_venue
       map.icon_global_init( gmaps_gicon('/images/gmaps/valigetta.png',45), "icon_#{person.id}_w" ) # person.icon_path
       map.overlay_init(
         GMarker.new( person.work_venue.fuzzied_coordinates, 
             :title => "#{person.name} (work)",
             :icon => Variable.new("icon_#{person.id}_w"),
             :info_window => "<b>#{person.name}</b> Work Info TBD - <br/>#{person.work_venue}<hr/>person.gmaps_info_window" 
           )
        )
      end
  end
  
  
  def add_to_map(obj,map)
    #log(yellow("AddToMap(#{obj} --> #{obj.class})"))
    case obj.class.to_s
      when 'Venue':   
        return add_venue_to_map(obj,map)
      when 'Event':   
        return add_event_to_map(obj,map)
      when 'Person':  
        return add_person_to_map(obj,map)
      else
        throw "Unknown class #{obj.class} wrt adding to a google map. Tryi implementing sth like 'add_#{obj.class}_to_map'"
    end
    return 
  end
 
    ######################################################
    # GoogleMap stuff for venue
     # Spostata brutalmente la roba dei venue: 
     def gmaps_marker(venue)
        GMarker.new( venue.coordinates, 
          :title => venue.name,
          :info_window => gmaps_info_window
        )
      end

    def add_venue_to_map(venue,map) # maybe a pointer??
      #venue=self
      venue_icon = magic_path(venue) || #my icon 
           magic_path(venue.venue_type) || #venue_type.icon_path || # my venueType Icon
           "/images/pizza.png"
      map.icon_global_init(gmaps_gicon(venue_icon), "icon_#{venue.id}" )
      map.overlay_init(
        GMarker.new( venue.coordinates, 
            :title => venue.name,
            :icon => Variable.new("icon_#{venue.id}"),
            :info_window => venue.gmaps_info_window
          )
       )
    end
    
    
    def add_event_to_map(event,map)
      icon_verde = '/images/gmaps/icong3.png'
      icon_event = event.icon_path
      ndays = ((event.tstart - Time.now) / 86400).to_i
      ndays = 0 if ndays > 25 # empty string if > 25
      my_icon = ndays < 1 ? '/images/gmaps/iconr.png' : # rosso
        "/images/gmaps/icong#{ndays}.png"
      gmap_add_point(map,my_icon,event,event.venue,
        "event.name (#{event.tstart})",
        event.gmaps_info_window
      )
    end
    
      # zoom = 0..17 (min..max)
    def center_map( map , venue, zoom = 12) 
      map.center_zoom_init( venue.coordinates , zoom ) #rescue false # venue.coordinates
    end
    
    ######################################################
      # writes a point for a generic object and a venue. The object has a to_s and a gmaps_info_window (maybe).
      # the venue gives us the X Y and other stuff
    def gmap_add_point(map,iconpaz,obj,venue,title,window,iconsize=45)
      map.icon_global_init( gmaps_gicon(iconpaz,iconsize), "icon_#{obj.id}" )
      map.overlay_init(
        GMarker.new( venue.coordinates, 
            :title => title,
            :icon => Variable.new("icon_#{obj.id}"),
            :info_window => window # (obj.gmaps_info_window rescue "'Warning! Object #{obj} (class: #{obj.class}) doesnt define method 'gmaps_info_window'!!! Clieck here for details: <HR/> #{link_to(obj,obj)}" )
          )
       )
    end
  
end
