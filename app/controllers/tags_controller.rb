class TagsController < ApplicationController

 # before_filter :populate_all_tags
 before_filter :login_required
    
    def index
      @tags = @all_tags
    end
    
    def model_find(model,tag)
      Tag.model_find(model,tag)
    end
    
    def show
      @tag = params[:id] || 'swdev'
      #@tag_hash = {}
      @htags = Tag.find_all_by_tag(@tag)
    end
    
    private 

      # shouldnt be in a controller, obviously, sorry! TBD_ELEGANCE
    def get_tags(model)
      model.find(:all, :limit => 20).select{|x| 
        x.tags.split(/\s+/).include?(@tag) if x.tags
      } rescue [ 'exception', 'get_tags', "Exception: #{$!}" ]
    end


end
