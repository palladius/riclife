class ProjectsController < ApplicationController
  
  before_filter :login_required

  active_scaffold  :project  do |config|
    #config.columns[:identity].form_ui = :select
    list.columns.exclude :created_at, :updated_at,  :description #, :url, :db_uri, :language, :svn_uri
    list.columns.exclude :date_due
    
   # config.columns[:identities].form_ui = :select
    config.columns[:person].form_ui = :select
    list.per_page = 100
  end

end
