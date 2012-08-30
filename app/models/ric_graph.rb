
=begin
  wrappa il concetto di grafico..

=end

class RicGraph  # < ActiveRecord::Base
  @@graph_version = '0.9.3'
  attr_accessor :nodes, :edges, :title
  
  def initialize(mytitle)
    @title = mytitle
  end
  
  def valid?
    return false unless @title.is_a?(String)
    return false unless @nodes.is_a?(Array)
    return false unless @edges.is_a?(Array)
    
    return true
  end
  
  def to_s
    "RicGraph '#{title}' (#{valid? ? :ok : :err})" rescue "RicGraph.Errors(#{$!})"
  end
  
  def get_description
    arr = {
      :str => to_s ,
      :nnodes => nodes.size,
      :nedges => edges.size,
    }
    arr
  end
  
  def to_dot_notation
    return [ 
      "digraph GGraph_#{graph_name} {", 
      mygraph.nodes.map{|f| f.to_dot if f.graphable? rescue "GraphNodeErr for '#{f} (cls=#{f})': ''#{$!}''"  }.compact , 
      mygraph.edges.map{|f| f.to_dot if f.graphable?(15) and f.relative?() rescue "GraphEdgeErr for '#{f}': ''#{$!}''" }.compact , 
      "}"
    ].join("\n") rescue " digraph GGraph_#{graph_name} { ECCEZZZIONE -- 'Graph.to_dot' -- '#{ ($!.to_s).gsub(/[\'\n ]/,'_') }' } "
  end
  
  def self.get_dot(graph_name, opts )
    #logga("graphname=#{graph_name}, opts=#{opts.inspect}")
    graph_name = graph_name.to_s.to_sym rescue "_GRAPHNAME_ERR_(#{$!})_"
    mygraph = generate_graph(graph_name, opts)
      # good
    if mygraph  && mygraph.is_a?(RicGraph)
      return [ 
        "digraph GGraph_#{title} {", 
        mygraph.nodes.map{|f| f.to_dot if f.graphable? rescue "GraphNodeErr for '#{f} (cls=#{f})': ''#{$!}''"  }.compact , 
        mygraph.edges.map{|f| f.to_dot if f.graphable?(15) and f.relative?() rescue "GraphEdgeErr for '#{f}': ''#{$!}''" }.compact , 
        "}"
      ].join("\n") rescue " digraph GGraph_#{graph_name} { ECCEZZZIONE -- 'Graph.to_dot' -- '#{ ($!.to_s).gsub(/[\'\n ]/,'_') }' } "
    end
      # not found
      # GraphVersion = #{@@graph_version}
    return <<-END_OF_GRAPH
        digraph RicGraph_#{graph_name} { 
          grafo_ignoto -> "graphname=#{graph_name}"     [color="yellow", URL="/friendships/1/edit", penwidth="1", label=""]
          grafo_ignoto -> "mygraph class=#{mygraph.class}"
          grafo_ignoto -> "mygraph string=#{mygraph}"
        }
     END_OF_GRAPH
  end
  
    # Static method that s a factory of graphs
  def self.generate_graph(graph_name,opts)
    # assert opts is a hash
    g = RicGraph.send("autograph_#{graph_name.to_s}", opts) rescue "Apparently Couldnt find a RicGraph with name '#{graph_name}': #{$!}"
    #assert(g.is_a?( RicGraph))
    return g
  end
  
  def self.find_all
    RicGraph.methods.select{|m| m.match /^autograph_/}.map{|name| name.gsub(/^autograph_/,'') }
  end
  
    # returns a graph
  def self.autograph_person_family(opts)
    opts[:person_id] ||= 2 # Fabio Mattei
    graph = RicGraph.new('person_family')
    graph.nodes = Person.find( 1 )
    graph.edges = Friendship.find(1)
    graph
  end
  
  def self.autograph_rails_models(opts)
    exclude_models = [] # [ City ]
    Dir.glob(RAILS_ROOT + '/app/models/*.rb').map{ |file| require file }
    all_models = Object.subclasses_of(ActiveRecord::Base).sort{|x,y| x.to_s <=> y.to_s}
    models = all_models - exclude_models # forse serve select where model.to_s non matchi l'altro array
    #@controllers = %w{ _CONTROLLERZ_TBD_ }
    graph = RicGraph.new('rails_models')
    graph.nodes = models
    graph.edges = []
  end
  
  def self.autograph_person_loves(opts)
    opts[:person_id] ||= 2 # Fabio Mattei
    graph = RicGraph.new
    graph.nodes = Person.find( 1 )
    graph.edges = Friendship.find(1)
    graph
  end
  
end