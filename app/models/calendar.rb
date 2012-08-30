# require 'rubygems' # Unless you install from the tarball or zip.
# require 'icalendar'
# require 'date'
# include Icalendar # Probably do this in your class to limit namespace overlap


class Calendar < ActiveRecord::Base
  require 'open-uri'
  DEFAULT_TIMEZONE = "Ireland/Dublin"
  VALID_COLORS = %w{ red green blue navy purple orange yellow darkgray dgray lightgray }.sort

  acts_as_commentable 
    
  belongs_to :person
  has_many :events, :order => 'tstart' #,  :conditions => ['events.active = ?', true]
  
  validates_length_of   :abbrev, :in => 2..5, :allow_nil => false
  validates_associated  :person, :message => "needs to belong to a Person"
  validates_presence_of :person
  validates_presence_of :name
  validates_inclusion_of :color, :in => VALID_COLORS , 
    :message => "Color {{value}} is not included in the list: #{VALID_COLORS.join(', ')}"
  
  #TBD validate max un MAIN per ogni utente :e dovrebbe essercene ESATTAMENTE uno a utente!
   
  searchable_by :name, :description

  def to_s
    name.capitalize rescue "ErrCalName{$!}"
  end
  
  def size # TBD
    events.size rescue 42
  end
  
    # TBR
  def my_events
    Event.find_all_by_calendar_id_and_active(self.id, false)
  end

  def local_events
    events
  end
  
  def abbrev
    #o anche: self[:abbrev].to_i
    read_attribute(:abbrev) || '_UNKN_ABBREV_' rescue "_ABBREV_EXCEPT(#{$!})_"
  end
  
  def to_label()
    "{#{self.person.initials.upcase rescue "??" }} #{name.capitalize}"
  end
  
  def headlines
    "<h5>#{title rescue 'titolo_BOH_' }'s headlines</h5>\n" + self.events.map{|e| e.headline } rescue "Calendar::headlines except #{__LINE__}: #{$!}"
  end

  def build_icalendar(descr, debug = true)
    ical = Icalendar::Calendar.new
    tz = Icalendar::Timezone.new
    tz.timezone_id = timezone || DEFAULT_TIMEZONE # "Ireland/Dublin"
    self.events.each do |evt|
      ical.add( evt.to_ical_event ) if evt.pubblicable?
    end
    return ical
  end

  def external
    @external || false
  end
  def private(); @private || false ; end

  def remote_events(create_event_locally = false)
    return [] unless url
    return [] unless external
    # Splitto su tutto, per parsarlo bene dovrei PRIMA splittare su VBEGIN/VEND e POI sul resto ;)
    open(url).read.split("\n").map{|x|
      if x.match(/^SUMMARY/)
        summary = x.gsub(/^SUMMARY:/,"").capitalize rescue "ErrCapit(#{$!})"
        "(R) #{summary}"
        if create_event_locally
          Event.create(
            :calendar_id => self.id,
            :creator_id => Person.find_by_nickname('palladius').id, # per non sbagliare :)
            :summary => summary,
            :description => "created with remote events :) sucked locally from remote ICS! TBD take EVERYTHING of the ICS from begin to END should be a fairly easy regex!"
          )
        end
      end
    } - [nil ]  rescue "RemoteEvts some error: #{$!}"
  end

  def misc_events
    tot_events = []
    tot_events << local_events if local_events
    tot_events << remote_events if remote_events
    #(local_events + remote_events ) rescue "Some error: #{$!}"
    tot_events
  end
  
  # def valid?
  #   'boh'
  # end
  
    # ColorsHelper::HTML_COLORS
  def mycolor
    @color || "LightSlateGray" 
  end
  
end

#require 'ICalendar'
#
#class Icalendar::Calendar
#  def headlines
#    "666 Errore: healdines for Ical::Cal non il mio !!!"
#  end  
#end
