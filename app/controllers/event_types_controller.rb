class EventTypesController < ApplicationController

  active_scaffold :event_type do |config|
    list.columns.exclude :created_at, :updated_at 
#    list.columns.add :duration, :creator
#    config.columns[:venue].form_ui = :select
#    config.columns[:creator].form_ui = :select
    list.per_page = 100
    
     # se qualcuno la crea altrove, escludiamo un sacco di roba inutile:
      config.subform.columns.exclude :icon, :notes, :active
  end
  
  def show
    myid = params[:id] || 1 rescue 2
    @event_type = Event.find( myid )
    
  end

end
