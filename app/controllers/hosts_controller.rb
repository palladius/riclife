class HostsController < ApplicationController
  active_scaffold :host do |config|
    list.columns.exclude :created_at, :updated_at, :notes
    #list.columns.add :duration
    #config.columns[:venue].form_ui = :select
  end

end
