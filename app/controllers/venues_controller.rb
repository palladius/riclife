class VenuesController < ApplicationController
  before_filter :login_required
  active_scaffold :venue  do |config|
    list.columns.exclude :created_at, :updated_at, :url, :description, :address, :lat, :lng, 
      :private, :active, :mail, :phone, :tags, :vote, :comments
    list.columns.add :your_distance, :gmap
    show.columns.exclude :created_at, :updated_at, :url, :description, :address, :lat, :lng, 
      :private, :active, :mail, :phone, :comments
    show.columns.add :your_distance, :gmap, :edit
    
    config.list.always_show_search = true 
    list.per_page = 200
    config.columns[:venue_type].form_ui = :select
    config.columns[:comments].form_ui = :select
    
    # escludi quando crei altrove :)
    config.subform.columns.exclude :lat, :icon_path, :lng, :description, :url, :name,
      :active, :private
    
      config.create.columns.add_subgroup "Important" do |name_group|
        name_group.add :address, :name, :venue_type, :vote, :icon_path
      end
      config.create.columns.add_subgroup "Altro" do |name_group|
        name_group.add  :mail, :phone, :url, :description, :lat, :lng, :active, :private#, :tags
      end
    
   end
   
      # http://ym4r.rubyforge.org/ym4r_mapstraction-doc/
   def gmap_index
     @user = current_user rescue nil # get_user from auth socmel
     @map = GMap.new("venue_map_div")
     @map.control_init(:large_map => true, :map_type => true)
     default_venue = (current_user.person.venue rescue Venue.find(:first)  )  # TBD you.location
     center_map( @map,default_venue )
     Venue.find(:all).each{|venue|
       add_venue_to_map(venue,@map)
     }
   end
   
   def gmap_show
      @venue = Venue.find( params[:id] )
      @map = GMap.new("venue_map_div")
      @map.control_init(:large_map => true, :map_type => true)
      center_map( @map, @venue )
      add_venue_to_map(@venue,@map)
   end
   
   def show
     @venue = Venue.find(params[:id])
     respond_to do |format|
       format.html # show.html.erb
       format.xml  { render :xml => @venue }
     end
   end
   
end
