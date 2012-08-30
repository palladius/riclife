  # $Id$
  
class FriendshipsController < ApplicationController
  
	#caches_page :index , :update_dotsvg  # cache la foto
	# figoso, cache condizionale:
	# caches_page :index, :if => Proc.new { |c| !c.request.format.json? }
  

  Mime::Type.register "image/png",     :png
  Mime::Type.register "image/jpeg",    :jpg
  Mime::Type.register "image/svg+xml", :svg

      # trovato qui: 
      # http://nb.inode.co.nz/articles/graphviz_on_rails/index.html
    def update_dotsvg
      respond_to do |format|
        format.html { render :html => render_dot('svg') } # index.html.erb
        format.xml  { render :xml  => render_dot('svg') }
        format.png  { render :png  => render_dot('png') }
        format.jpg  { render :jpg  => render_dot('jpg') }
      end
    end
    
    def graph_family
      respond_to do |format|
        format.html { render :html => render_dot_generic('family','svg') } # index.html.erb
        format.xml  { render :xml  => render_dot_generic('family','svg') }
        format.png  { render :png  => render_dot_generic('family','png') }
        format.jpg  { render :jpg  => render_dot_generic('family','jpg') }
      end
    end
    
    def new
      @record = Friendship.new(
        :person_id => params[:person_id], 
        :followed_id => params[:followed_id] ,
        :notes => params[:notes] ,
        :tags => params[:tags] ,
        :importance => params[:importance] 
      )
      @friendship = @record
        respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @friendship }
        end
    end
    
    def index
      @friendships = Friendship.all # ( :limit => 5 ) # rimuovi in production
      respond_to do |format|
        format.html 
        format.xml  { render :xml => @friendships }
      end
    end
    
      # devo invalidare la cache direi
    def create
      @friendship = Friendship.new(params[:friendship])
      respond_to do |format|
        if @friendship.save
          flash[:notice] = 'friendship was successfully created.'
          invalidate_cache
          format.html { redirect_to(@friendship) }
          format.xml  { render :xml => @friendship} # , :status => :created, :location => @person }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @friendship.errors, :status => :unprocessable_entity }
        end
      end
    end
    
    def edit
      @friendship = Friendship.find(params[:id])
    end
    
    def show
      @friendship = Friendship.find(params[:id])
      @current_user = current_user rescue nil
      respond_to do |format|
        format.html 
        format.xml  { render :xml => @friendship }
      end
    end
    
    def update
       @friendship = Friendship.find(params[:id])
       respond_to do |format|
         if @friendship.update_attributes(params[:friendship])
           invalidate_cache
           flash[:notice] = "Friendship ##{@friendship.id} was successfully updated: #{ params[:friendship].inspect }."
           format.html { redirect_to(@friendship) }
           format.xml  { head :ok }
           format.js   { head :ok }
         else
           format.html { render :action => "edit" }
           format.xml  { render :xml    => @friendship.errors, 
                                :status => :unprocessable_entity }
           format.js   { head :unprocessable_entity }
         end
       end
     end
    
    
    def render_dot(file_type)
      gv=IO.popen("/usr/bin/dot -q -T#{file_type}","w+")
      gv.puts( Friendship.to_dot(:update_dotsvg) )
      gv.close_write
      @gvsvg=gv.read
    end
    
      # prog may be 'dot' or 'neato', neatp e' illeggibile///
    def render_dot_generic(graph_name,file_type)
      gv=IO.popen("/usr/bin/dot -q -T#{file_type}","w+")
      gv.puts( Friendship.to_dot(graph_name) )
      gv.close_write
      @generic_svg = {
        :name => graph_name,
        :data => gv.read,
      }
      return @generic_svg[:data]
    end

    def graph_index
      @friendships = Friendship.all
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @friendships }
        #format.svg  { render :svg => @identities }
        #format.dot  { render :dot => @identities }
        #format.text { render :dot => @identities }
      end
    end
    

      
end
