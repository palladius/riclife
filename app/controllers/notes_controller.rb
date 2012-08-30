class NotesController < ApplicationController

  # http://codeintensity.blogspot.com/2008/02/auto-complete-text-fields-in-rails-2.html
  #auto_complete_for :project, :title

  active_scaffold :note do |config|
    list.columns.exclude :created_at, :updated_at,
      :tags, :description, :vote, :icon_path, :relevance, :active
    config.columns[:project].form_ui = :select
  end
  

  def show
    @note = Note.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end
  
  # def index
  #   @notes = Note.all # ( :limit => 5 ) # rimuovi in production
  #   respond_to do |format|
  #     format.html 
  #     format.xml  { render :xml => @notes }
  #   end
  # end

end
