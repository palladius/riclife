class SportActivitiesController < ApplicationController
  
  #auto_complete_for :activity, :name
  
  active_scaffold :sport_activity do |config|
    list.columns.exclude :created_at, :updated_at, :description, :calories
#    list.columns.add :auto_calories
    list.per_page = 10
    config.list.sorting = { :date => :desc }
    #config.columns[:person].form_ui = :select
  end
  
  # # GET /sport_activities
  # # GET /sport_activities.xml
  # def index
  #   @sport_activities = SportActivity.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @sport_activities }
  #   end
  # end
  # 
  # # GET /sport_activities/1
  # # GET /sport_activities/1.xml
  # def show
  #   @sport_activity = SportActivity.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @sport_activity }
  #   end
  # end
  # 
  # # GET /sport_activities/new
  # # GET /sport_activities/new.xml
  # def new
  #   @sport_activity = SportActivity.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @sport_activity }
  #   end
  # end
  # 
  # # GET /sport_activities/1/edit
  # def edit
  #   @sport_activity = SportActivity.find(params[:id])
  # end
  # 
  # # POST /sport_activities
  # # POST /sport_activities.xml
  # def create
  #   @sport_activity = SportActivity.new(params[:sport_activity])
  # 
  #   respond_to do |format|
  #     if @sport_activity.save
  #       flash[:notice] = 'SportActivity was successfully created.'
  #       format.html { redirect_to(@sport_activity) }
  #       format.xml  { render :xml => @sport_activity, :status => :created, :location => @sport_activity }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @sport_activity.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # PUT /sport_activities/1
  # # PUT /sport_activities/1.xml
  # def update
  #   @sport_activity = SportActivity.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @sport_activity.update_attributes(params[:sport_activity])
  #       flash[:notice] = 'SportActivity was successfully updated.'
  #       format.html { redirect_to(@sport_activity) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @sport_activity.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /sport_activities/1
  # # DELETE /sport_activities/1.xml
  # def destroy
  #   @sport_activity = SportActivity.find(params[:id])
  #   @sport_activity.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(sport_activities_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
