class KeyvalsController < ApplicationController
   active_scaffold :keyval
  before_filter :login_required
  before_filter :admin_required
  
  active_scaffold :keyval do |config|
    list.columns.exclude :created_at, :updated_at
    columns[:key].label = "Chiave"
    columns[:val].label = "Valore"
    columns[:description].label = "Descrizione"
  end
=begin
 active_scaffold :circuit do |config|
    config.label = "Circuits (formerly known as LINES)"
    config.columns = [
      #:link_type,
      :name,
      :site_from_id ,
      :site_to_id,
      #:site,
      #:site_to ,
      :circuit_type
      ]
    #list.columns.exclude :comments
    #list.columns.include :notes
    columns[:name].label = "Circuit name"
    #columns[:photo].label = "Photo (this would be a binary property)"
    #columns[:birth].label = "Date of birth"
    #columns[:birth].label = "Date of birth"
    #columns[:birth].description = "(Format: ###-###-####)"
  end

=end
end
