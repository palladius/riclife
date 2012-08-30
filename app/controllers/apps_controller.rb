class AppsController < ApplicationController
  
  before_filter :login_required

  active_scaffold  :app  do |config|
    # #  list.columns.add     :nomecognome
    # #config.columns[:identity].form_ui = :select
    list.columns.exclude :created_at, :updated_at, :url, :db_uri, :description, :language, :svn_uri, :local_path, :people, :identities
    #list.columns.add :autovalid
    
    update.columns.exclude :updated_by, :created_by, :people, :identities
    create.columns.exclude :updated_by, :created_by, :people, :identities
    
#
#     config.columns[:identities].form_ui = :select
#    config.columns[:people].form_ui = :select
    list.per_page = 100
  end
  
  # active_scaffold :app
     
  # def index    
  # end

end
