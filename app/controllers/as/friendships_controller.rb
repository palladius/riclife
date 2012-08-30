  # $Id$
  
class As::FriendshipsController < ApplicationController
  
  Mime::Type.register "image/png",     :png
  Mime::Type.register "image/jpeg",    :jpg
  Mime::Type.register "image/svg+xml", :svg
  
    active_scaffold :friendship do |config|
      list.columns.exclude :created_at, :updated_at, :notes
      list.columns.add :valid, :tags 
      #, :reciprocated
      list.per_page = 100
      config.columns[:person].form_ui = :select
      config.columns[:followed].form_ui = :select
      #config.columns[:importance].form_ui = :select #[1,2,3,4,5]
    end


      # trovato qui: 
      # http://nb.inode.co.nz/articles/graphviz_on_rails/index.html
    def update_dotsvg
      # gv=IO.popen("/usr/bin/dot -q -Tsvg","w+")
      # gv.puts "# Creato da update_dotsvg un digrafo, speriamo.."
      # gv.puts( Friendship.to_dot )
      # gv.close_write
      # @gvsvg=gv.read
      respond_to do |format|
        format.html { render :html => render_dot('svg') } # index.html.erb
        format.xml  { render :xml => render_dot('svg') }
        format.png  { render :png => render_dot('png') }
        format.jpg  { render :jpg => render_dot('jpg') }
        #format.svg  { render :svg => @identities }
        #format.dot  { render :dot => @identities }
        #format.text { render :dot => @identities }
      end
      #render_dot('svg')
    end
    
    def render_dot(file_type)
      gv=IO.popen("/usr/bin/dot -q -T#{file_type}","w+")
      gv.puts( Friendship.to_dot )
      gv.close_write
      @gvsvg=gv.read
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
