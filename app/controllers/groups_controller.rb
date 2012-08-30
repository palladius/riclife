class GroupsController < ApplicationController
  
  active_scaffold   :group do |config|
    list.columns.exclude :created_at, :updated_at, :notes
    config.columns[:person].form_ui = :select
  end
end
