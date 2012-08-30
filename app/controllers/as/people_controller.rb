class As::PeopleController < ApplicationController
  #  require 'ym4r'  

  active_scaffold  :person do |config|
    list.per_page = 10 # 50
    list.sorting = {:surname => 'ASC'}  # o metti la relevance :)
    
    columns.exclude :apps, :calendars, :comments, :identities, :projects

    list.columns.add     :name_surname, :age #, #:autovalid
    list.columns.exclude :created_at, :updated_at, 
      :apps, :birthday, :updated_at, :published,
      :nickname, :male, :mobile, :notes, :relevance, :name, :surname, :organisation, :location,
      :strength, :wisdom, :charisma, :dexterity, :intelligence, :constitution, 
      :starred, :virtual, :work_venue,
      :calendars, :comments,
      :identities, :feed, :sexappeal, :vote, :tags,
      :created_by, :updated_by, 
      :age

    create.columns.exclude :calendars, :comments, :projects,    :created_by, :updated_by
    update.columns.exclude :updated_by, :created_by
      
      config.columns[:identities].form_ui = :select
      config.columns[:apps].form_ui = :select
      config.columns[:work_venue].form_ui = :select
      config.columns[:venue].form_ui = :select
      list.per_page = 100
    
    config.update.link.label = "<img src='/images/icons/edit.png' border='0' height='12' />"

    create.columns.add_subgroup "Anagraphics" do |name_group|
      name_group.add :name, :nickname, :surname, :mail, :mobile, :male, :birthday, :notes, :tags
    end
    config.create.columns.add_subgroup "Social" do |name_group|
      name_group.add :photo_name, :feed
    end
    config.create.columns.add_subgroup "D&D" do |name_group|
      name_group.add :strength, :wisdom, :dexterity, :constitution, :charisma , :intelligence
    end
    config.create.columns.add_subgroup "Where (home)" do |name_group|
      name_group.add :location, :venue
    end
    config.create.columns.add_subgroup "Where (work)" do |name_group|
      name_group.add :organisation, :work_venue
    end
    config.create.columns.add_subgroup "Cagate" do |name_group|
      name_group.add :starred, :virtual, :apps, :published, :sexappeal, :relevance, :vote
    end
  end
  
    # per lo scaffolding...
  def before_create_save(record)
     begin
      str = "\n[Last updated by: #{current_user rescue '_CURRENT_USER_BOH'} ]"
      record.notes = (record.notes + str) 
      record.created_by = current_user 
    rescue
      puts "errore: #{$!}"
    end
    return true
  end
  
  # http://activescaffold.com/docs/api-update
  def before_update_save(record)
    record.updated_by = current_user rescue 42
  end

  # # Condizione affinché uno possa vedere questa lista..
  # def conditions_for_collection
  #   @work_venue_id ||= 1 
  #   @venue_id ||= 1
  #   #false
  #   # ['work_venue_id is not NULL AND venue_id is not NULL ' ]
  #   ['people.id = 43' ] # 43 ok, 1 err
  # end

  # http://ym4r.rubyforge.org/ym4r_mapstraction-doc/
  def gmap_index
    @user = current_user
    @people = Person.all
    @map = gmap_create("venue_map_div")
    #@map = GMap.new("venue_map_div")
    #@map.control_init(:large_map => true, :map_type => true)
    #@map.center_zoom_init( Person.find(:first).venue.coordinates , 13 )
    @people.each{|person| #|venue|
      #venue = person.venue # to mo :)
      if person.venue
        add_to_map(person,@map)
       end
      }
  end
  
  def index
    @people = Person.all # ( :limit => 5 ) # rimuovi in production
    @npeople = 10
    @last_people = Person.all( :order => 'updated_at DESC', :limit => @npeople ) # rimuovi in production
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @people }
    end
  end
  
  def show
    @person = Person.find(params[:id])
    @current_user = current_user
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @person }
    end
  end
  
  # # GET /people/1/edit
  # def edit
  #   @person = Person.find(params[:id])
  # end

  def new_nonva_porca_pupazza
    @person= Person.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @person }
    end
  end
  
  def update
     @person = Person.find(params[:id])
     respond_to do |format|
       if @person.update_attributes(params[:person])
         flash[:notice] = "Person ##{@person.id} was successfully updated: #{ params[:person].inspect }."
         format.html { redirect_to(@person) }
         format.xml  { head :ok }
         format.js   { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml    => @person.errors, 
                              :status => :unprocessable_entity }
         format.js   { head :unprocessable_entity }
       end
     end
   end
  


   #config.actions << :export_tool # vedi http://dry.4thebusiness.com/companies

   # ideucce da qui: http://activescaffold.com/docs/api-core
   #config.dhtml_history = false # dice che va + veloce...
   #config.theme = :blue # AjaxScaffold look with a blue header
   #config.columns[:age].calculate = :avg
   #config.columns[:age].calculate = :sum
end
