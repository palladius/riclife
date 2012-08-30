class GugolCalendarsController < ApplicationController
 
   active_scaffold  :gugol_calendar  do |config|
      # #  list.columns.add     :nomecognome
      # #config.columns[:identity].form_ui = :select
      list.columns.exclude :created_at, :updated_at #, :url, :db_uri, :description, :language, :svn_uri, :local_path
      # 
      # config.columns[:identities].form_ui = :select
      # config.columns[:people].form_ui = :select
      list.per_page = 100
    end

 
 end
