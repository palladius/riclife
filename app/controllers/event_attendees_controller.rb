class EventAttendeesController < ApplicationController

    active_scaffold :event_attendee do |config|
      list.columns.exclude :created_at, :updated_at ,
        :busy, :confirmed
      list.per_page = 100
      config.columns[:person].form_ui = :select
      config.columns[:event].form_ui = :select
       # se qualcuno la crea altrove, escludiamo un sacco di roba inutile:
  #      config.subform.columns.exclude :icon, :notes, :active
    end

end
