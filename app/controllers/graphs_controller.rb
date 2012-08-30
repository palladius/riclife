class GraphsController < ApplicationController
  before_filter :login_required
  
  Mime::Type.register "image/png",     :png
  Mime::Type.register "image/jpeg",    :jpg
  Mime::Type.register "image/svg+xml", :svg

  def index
    @params = params
  end
  
  def show
    flash[:notice] = "Thanks for signing up! Params vale: #{params.inspect}"
    @params = params # devo debuggare sti cazzi di params!!!
    @graph_name = params[:id] || 'GRAPH_NAME_NOT_GIVEN_U_IDIOT'
    multi_format_responder(@graph_name, params )
  end
  
protected

  def multi_format_responder(graph_name, opts )
    @graph_data ||= RicGraph.get_dot(graph_name,opts)
    respond_to do |format|
      format.html #{ render :html => render_dot_generic2(graph_name, 'html', opts) }
      format.xml  { render :xml  => render_dot_generic2(graph_name, 'xml', opts) }
      format.png  { render :png  => render_dot_generic2(graph_name, 'png', opts) }
      format.jpg  { render :jpg  => render_dot_generic2(graph_name, 'jpg', opts) }
    end
  end
  
    # prog may be 'dot' or 'neato', neatp e' illeggibile///
  def render_dot_generic2(graph_name,file_type, opts )
    @graph_data ||= RicGraph.get_dot(graph_name,opts)
    gv=IO.popen("/usr/bin/dot -q -T#{file_type}","w+")
    #gv.puts( Gr aph.to_dot(graph_name,opts) )
    gv.puts( @graph_data )
    gv.close_write
    @generic_svg = {
      :name => graph_name,
      :data => gv.read,
    }
    return @generic_svg[:data]
  end
end
