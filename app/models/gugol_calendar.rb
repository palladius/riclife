class GugolCalendar < ActiveRecord::Base
  
  searchable_by :name, :calname, :description # , :tags
  
  def self.description
    "This class aims at wrapping a Google Calendar account + a default calendar (doesnt support MULTIPLE calendars yet!).
    Lets see what happens...
    
    Prova1: GCal4Ruby
    sembra facile da usare...
    
    Prova2: http://cookingandcoding.wordpress.com/2009/06/08/new-ruby-google-calendar-api-gem-gcal4ruby/
    
    sembra gestire meglio le ricorrenze
    
    "
  end
  
  
  # http://cookingandcoding.wordpress.com/2009/05/04/using-google-calendar-api-in-ruby-on-rails/
  def gcal_login
    # #Step 1: Setup feed url and create account service using constants
    #   service = GCal4Ruby::Service.new
    #   service.authenticate(GOOGLE_LOGIN, GOOGLE_PASS)    
  end

  def gcal_create(title = '_riclife' )
  #   #Step 2: Create a new calendar
  #   calendar = GCal4Ruby::Calendar.new(service)
  #   calendar.title = self.title # tile = 'A New Calendar'
  #   calendar.summary = self.description
  #   if calendar.save
  #    return true
  #   else
  #    return false
  #   end
  # 
  #   #Step 3: Make the calendar publicly available
  #   calendar.public = true
  #   
  end
  
  def events
    %w{ foo_event1 event2 event3 }
  end
  
end
