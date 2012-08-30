class VenueTypesController < ApplicationController
  before_filter :login_required
  
  active_scaffold :venue_type  do |config|
    list.columns.exclude :created_at, :updated_at, :active, :description
    # se qualcuno la crea altrove, escludiamo un sacco di roba inutile:
    config.subform.columns.exclude :description, :icon_path, :active
    list.per_page = 200
    config.list.sorting = { :name => :asc }
   end
end
