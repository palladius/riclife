
require 'icalendar'

# scopiazzato da:
# http://blog.milesbarr.com/2006/06/icalendar-and-rails/
# http://railsforum.com/viewtopic.php?id=596
# http://icalendar.rubyforge.org/

# Metti questo quando crei o cancelli o modifichi un evenbto:
# expire_page :controller => "ical", :action => "competitions"

# TBD RIMUOVIMI, concettualmente la classe calendar deve fare sto lavoro...

class IcalController < ApplicationController

  # TOD OIMP T B D rimettimi l'ho tolto solo per test (cazzo cache pure in devel!!!)
  #caches_page :competitions if (RAILS_ENV == 'production')

  def all
    @ical = Icalendar::Calendar.new
    Event.find_all.each do |comp|
      event = Icalendar::Event.new
      event.start = Time.now
      event.end =  Time.now
      event.summary = "Foo Ric1 ical_controller::competitions statico mettici eventi veri (comp.name)"
      @ical.add event
    end
  end

  # tutti, TBD mettine solo uno... come restful ma magari allora usa EVENTI :)
  def show
    @ical = Event.build_calendar('Creato da show')
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ical }
      format.text  { render :text => @ical }
      format.ics  { render :ics => @ical }
    end
  end

  # tutti
   def index
    @ical = Event.build_calendar('Creato da ical/index')
    respond_to do |format|
      format.html # show.html.erb
      #format.xml  { render :xml => @ical }
      format.text  { render :text => @ical }
      format.ics  { render :ics => @ical }
    end
  end

end
