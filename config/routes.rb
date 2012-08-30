ActionController::Routing::Routes.draw do |map|
  map.resources :riccities

  @activescaffoldable_models = [ Person, Friendship, Note ] 
  
  #map.resources :nifty_people
  map.resources :ricfiles
  # fatto a manhouse
  map.resources :tags
  map.resources :pages
  map.resources :gugol_calendars
  map.resources :sport_activities
  map.resources :magic_urls
  map.event_view '/event_view/:year/:month', :controller => 'event_view', :action => 'index', :year => Time.zone.now.year, :month => Time.zone.now.month

  #map.root :action => (ApplicationHelper::ACTIVESCAFFOLDABLE_MODELS.to_s)
  map.root :controller => "site"

		# deve stare oprima delle risorse se no se lo ciucciano..
  map.connect 'people/gmap',                :controller => "people",      :action => 'gmap_index'
  map.connect 'calendars/gmap',             :controller => "calendars",   :action => 'gmap_index'
  map.connect 'venues/gmap',                :controller => "venues",      :action => 'gmap_index'
  map.connect 'friendships/graph',          :controller => "friendships", :action => 'graph_index'
  map.connect 'friendships/update_dotsvg',  :controller => "friendships", :action => 'update_dotsvg'
  map.connect 'friendships/update_dotsvg.:format',  :controller => "friendships", :action => 'update_dotsvg'
  map.connect 'friendships/graph_family.:format',   :controller => "friendships", :action => 'graph_family'

  # map.connect 'graphs/network_index',         :controller => "graphs", :action => 'network_index' # '' -> html
  # map.connect 'graphs/network_index.:format', :controller => "graphs", :action => 'network_index' #  html, svg, png, ...
  # map.connect 'graphs/network_svg',         :controller => "graphs", :action => 'network_svg'
  #map.connect 'graphs/:action.:format', :controller => 'graphs'
  map.resources :graphs
  # roba NON scaffolded:
  map.resources :importer
  map.resource :session

  map.resources :users
  map.resources :gmaps
  map.resources :ical,  :member => { :competitions => :get }
  map.resources :photo_types
  map.resources :mailings, :member => { :deliver => :post }
    # roba scaffolded
  map.resources :apps, :active_scaffold => true
  map.resources :comments, :active_scaffold => true
  map.resources :calendars, :active_scaffold => true
  map.resources :cities
  map.resources :countries, :active_scaffold => true
  map.resources :event_attendees
  map.resources :event_types, :active_scaffold => true
  map.resources :events, :active_scaffold => true,      :member => { :gmap => :get }
  map.resources :friendships #, :active_scaffold => true
  map.resources :gms # , :active_scaffold => true
  map.resources :groups, :active_scaffold => true
  map.resources :hosts, :active_scaffold => true
  map.connect 'identities/contacts',          :controller => "identities",    :action => 'contacts'      #    see the contacts from GMail, Hotmail, ...
  #map.connect 'identities/:id/import_contacts',   :controller => "identities",    :action => 'import_contacts'   # import the contacts from GMail, Hotmail, ...
  map.resources :identities, :active_scaffold => true # ,  :member => { :graph => :get }
  map.resources :keyvals, :active_scaffold => true
  map.resources :libraries, :active_scaffold => true  
  map.resources :loans, :active_scaffold => true
  map.resources :notes, :active_scaffold => true
  map.resources :people, :active_scaffold => true
  map.resources :photos, :active_scaffold => true
  map.resources :projects, :active_scaffold => true
  map.resources :recipes, :active_scaffold => true
  map.resources :venue_types, :active_scaffold => true
  map.resources :venues,  :active_scaffold => true,     :member => { :gmap => :get }
  


  # copiato da qui: http://avnetlabs.com/rails/restful-authentication-with-rails-2
  map.login  '/login',  :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  
  # TODO   person GET    /people/gmap/:id(.:format)       {:action=>"gmap_show", :controller=>"people"}

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end
  
  # [ Person, Friendship, Note, EventAttendee ] 
  # => [:people, :friendships, :notes, :event_attendees]
  map.namespace :as do |active_scaffoldume|
    # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
    @activescaffoldable_models.each{|mymodel| 
      symbolized_model = mymodel.to_s.tableize.to_sym 
      active_scaffoldume.resources symbolized_model,  :active_scaffold => true 
    } 
    # active_scaffoldume.resources :people
    # active_scaffoldume.resources :friendships
    # active_scaffoldume.resources :identities, :active_scaffold => true # ,  :member => { :graph => :get }
    # active_scaffoldume.resources :venues,  :active_scaffold => true # ,     :member => { :gmap => :get }
  end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
