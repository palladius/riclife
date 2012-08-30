class CalendarsController < ApplicationController
   
  active_scaffold :calendar do |config|
    list.columns.exclude :created_at, :updated_at, :description , :events , :misc_events , :url,
      :vote, :timezone, :tags, :icon_path, :color, :person
    list.columns.add :valid?, :size
    config.columns[:person].form_ui = :select
    #config.columns[:events].form_ui = :select
  end
  
  # http://ym4r.rubyforge.org/ym4r_mapstraction-doc/
  def gmap_index
    @you = current_user
    @default_venue = current_user.venue rescue Venue.last
    @calendars = Calendar.all # TBD raffina con I MIEI calendari
    @map = gmap_create( "calendar_map_div", @default_venue ) # da dove centrarla
    @calendars.each do |calendar| #|venue|
      calendar.events.future.each do |event|
        add_event_to_map(event,@map) if event.venue
      end
    end
  end
  
  def show
    @calendar = Calendar.find(params[:id])
    @ical = @calendar.build_icalendar("Calendar ##{@calendar.id}: #{@calendar.name}")
    respond_to do |format|
      format.html
      format.xml   { render :xml  => @ical }
      format.text { render :text => @ical.to_ical } # { render :text => @ical }
      format.ics   { render :ics  => @ical }
    end
  end

end
