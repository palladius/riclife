
=begin 
	TODO
	prova con vpim sembra fico!

		http://vpim.rubyforge.org/

=end

require 'icalendar'

class Event < ActiveRecord::Base

  searchable_by :summary, :description
  #acts_as_voteable   # http://juixe.com/techknow/index.php/2006/06/24/acts-as-voteable-rails-plugin/
  acts_as_commentable # http://juixe.com/techknow/index.php/2006/06/18/acts-as-commentable-plugin/

  DFLT_REPEAT_FRREQUENCY = 'none'

  belongs_to :venue
  belongs_to :event_type
  belongs_to :creator, :foreign_key => 'creator_id' , :class_name => 'Person'
  belongs_to :calendar
  #has_many  :people #, :foreign_key => 'person_id' , :class_name => 'EventAttendee'

  validates_presence_of :tstart # lo creo con il pre validatore :) , :tend

  named_scope :recent_created, lambda { { :conditions => ['created_at > ?', 1.week.ago] } }
  named_scope :close , lambda { { :conditions => ['tstart < ?', Time.now + 5.week] } }
  named_scope :test,   lambda { { :conditions => ['summary LIKE ?', '%test%'] } }
  named_scope :future, lambda { { :conditions => ['tstart > ?', Time.now] } }
  named_scope :past,   lambda { { :conditions => ['tstart < ?', Time.now] } }
  named_scope :pubblicable , lambda { { :conditions => ['active = ?', true ] } }

    # esigi che ci sia il summary
  validates_presence_of :summary
  validates_format_of :repeat_frequency, :with => /^(|day|beweek|week|month|year)$/, 
    :message  => "Legal value are: none (default), day, week, beweek, month, year"

    # gli passi 'name' e ritorna "Name: #{name}" se ha un name se no un cacchio
  def kv(obj)
    val = self.send(obj).to_s rescue "Err w/ func '#{obj}'"
    val.size > 0 ? 
      "#{obj.capitalize}: #{val}" : 
      '' #{ }"DEB_NISBA: #{obj}"
  end


  # catch all per infilare l'intelligenza del mio coso dentro alla descrixzione...
  def full_description(ulterior_desc='', debug = false)
    return (description rescue '(no desc.)' ) unless debug
    arr_descr = [ 
      "Full Description:",
			kv('description'), 
			kv('location'), 
      kv('repeat_frequency'), 
      kv('repeats'), 
      kv('url'), 
      kv('price') ,
      kv('active') ,
      kv('repetition_magic_string'),
      "#RICCAL=#{self.calendar.abbrev rescue "No Abbrev available"}",
      'Ulteriore descrizione: ',
      ulterior_desc ,
      ]
    if self.venue
      arr_descr << self.venue
      #arr_descr << self.venue.lat.to_s
    end
    return arr_descr[debug].join("\n--\n") # rescue "Exception w/ full_description: #{$!}"
  end

  def self.build_calendar(descr, debug = true)
    cal = Icalendar::Calendar.new
    timezone = Icalendar::Timezone.new
    timezone.timezone_id = "Ireland/Dublin"
    Event.pubblicable.find(:all).each do |evt|
      cal.add( evt.to_ical_event(false) ) if (evt.active? && evt.class == Event)
    end
    return cal
  end
  
  

=begin
    Casi reali:
  RRULE:FREQ=YEARLY;INTERVAL=1;WKST=MO
  RRULE:FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,WE,FR;WKST=MO
  RRULE:FREQ=DAILY;UNTIL=20091212T090000Z;INTERVAL=1;WKST=MO
  #'day'  => 'FREQ=DAILY;UNTIL=20091212T090000Z;INTERVAL=1;WKST=MO'
  #'day'  => "FREQ=DAILY;#{until_str}INTERVAL=1;WKST=MO\n",
  #'day'  => "FREQ=DAILY;INTERVAL=1;WKST=MO\n",
=end
    # TBD sposta nell'helper
  def repetition_magic_string_key(key, opt={})
    until_str = ''
    until_str = "UNTIL=#{opt[:until]};" if opt[:until]
    #week_start = 'MO' # son italiano :)
    repetitions_map = {
      'year' => "FREQ=YEARLY",
      'month'  => "FREQ=MONTHLY",
      'week' => "FREQ=WEEKLY" ,     
      'day'  => "FREQ=DAILY",
    }
     repetitions_map.fetch(key,'') # no rrule => empty str
  end

  def repetition_magic_string(opt={})
    return '' unless repeats
    return repetition_magic_string_key(repeat_frequency,opt)
  end
  
  def pubblicable?
    active # active
  end
  
  def ical_summary()
    "[#{calendar.abbrev rescue '_MAH_'}] #{summary}" rescue "Err Summary(#{$!})"
  end
  
  # TBD relazione rails (credo come has_many ?)
  def attendees
    EventAttendee.find_all_by_event_id(self.id)    
  end

    # singolo evento to ics...
  def to_ical_event(set_alarm = true)
    $version = "0214.2"
    e = Icalendar::Event.new
    k=0
    evt_url = "https://riclife.palladius.eu/events/#{id}"
    my_description = # "[repetition_magic_string: '#{repetition_magic_string}']" + 
      "#evt_url: #{evt_url}"
    begin
      e.summary     = ical_summary()  # "[#{calendar.abbrev rescue '_BOH_'}] #{summary}"
      e.dtstart     = DateTime.parse(tstart.to_s)
      e.dtend       = DateTime.parse(tend.to_s)  
      e.location    = venue.address rescue "(Venue Unknown)"
      e.klass       = self.private ? "PRIVATE" : "PUBLIC"
      e.ip_class    = e.klass
      e.description = full_description(my_description) rescue "Err rendering full_description: #{$!}"
      attendees.each{ |x| 
        k += 1
        e.add_attendee( x.full_mail(" (Attendee #{k})") ) rescue nil
      } # attendee
      e.add_attendee( creator.full_mail(" (Creator)") ) rescue nil
      e.alarm do # allarme funge!!!
        action        "DISPLAY" # This line isn't necessary, it's the default
        summary       "Alarm notification Riccardo"
        trigger       "-P1DT0H0M0S" # 1 day before
      end if set_alarm
      e.geo =  Icalendar::Geo.new(venue.lat , venue.lng) if (defined?(venue.lat) && defined?(venue.lng) )
      e.url = evt_url
      if repeats       # repeats, per comodita lo faccio weekly...
        puts("Aggiungo una rrule..")
        e.add_recurrence_rule(repetition_magic_string()) 
      end
    rescue
      e.description = "Event.to_ical_event(ver=#{$version}) Some exception:\nMsgErr= ''#{$!}'' \n\nMsgCall='''#{caller.join("\n -- ")}'''"
    end
    return e
  end

  def to_ical
    to_ical_event(false).to_ical
  end

  def name
    summary
  end

  def to_label
    summary
  end

  def concise
    #"<b>#{summary}</b>@#{location} <i>(#{tstart})</i>"
    "<b>#{summary}</b>, #{location}"
  end

  def to_s
    summary
  end

  #  def before_validation_on_create() 
  def before_validation() 
    self.tstart = Time.now      unless attribute_present?("tstart")    # 1h avanti
    self.tend = (tstart + 3600)  if (attribute_present?("tstart") && ! attribute_present?("tend") ) rescue nil  
      # 1h avanti
    logger.debug "Tstart: #{tstart} // class: #{tend.class}"
    logger.debug "Tend: #{tend} // class: #{tend.class}"
    self.repeat_frequency = DFLT_REPEAT_FRREQUENCY unless attribute_present?("tend")           # nessuna ripetizione
  end

	def validate
    return if tstart.nil? # ci pensa il validate suo ;)
    return if tend.nil? # ci pensa il validate suo ;)
		if tend < tstart
			errors.add("Event cannot start AFTER it has ended :)")
		end
	end

  def past?
    tstart < Time.now()
  end


    # active now is a boolean.
    # I show this in homepage if its NOT n the past AND if its active, hough
#  def active?
  def homepage_active?
    active && (! past?)
  end
  
  def gmaps_info_window
    return <<-SNIPPET_EVENT
       <a href='/events/#{id}'><h2>#{name}</h2></a>
     <img src='#{icon_path}' height='70' valign='top' align='right' /> 
     <small><a href='/venues/#{venue.id}'>#{venue.address || 'Address unknown' }</a></small> 
      <hr/> 
     #{ "<pre>#{description}</pre>" if description}
     #{"Start: #{tstart}" if tstart}
     <a href='/events/#{id}/edit'>EDIT</a>
     SNIPPET_EVENT
  end
  
  def headline
    "<b class='event'>#{summary}</b> @<i>#{venue.address}</i>"
  end
  #alias :title :summary

end
