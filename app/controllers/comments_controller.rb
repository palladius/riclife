class CommentsController < ApplicationController
  before_filter :login_required
  
   active_scaffold :comment  do |config|
     list.columns.exclude :created_at, :updated_at, :commentable_type, :title, :body, :user
     list.columns.add :snippet, :resource_link , :user_id
     config.columns[:user].form_ui = :select
     
     columns.add :commentable_id #, :autovalid
     #columns.add :commentable_type
     
      # figosissimo! Provel!
     #config.columns[:column_name].options = {:html_options => {:onchange => "alert('hi')"}}
     #config.columns[:identities].form_ui = :select
     config.columns[:user_id].form_ui = :select
     config.columns[:commentable_type].form_ui = :select # :record_select # %w{ ab cd} 
      # COMMENT_VALID_TYPES = Object.subclasses_of(ActiveRecord::Base).sort{|x,y| x.to_s <=> y.to_s}
     list.per_page = 100
     config.list.sorting = { :commentable_type => :asc }
   end
   
#    def record_select_conditions_from_controller
#      [ 1,2,3,42 ]
# #     ["project_items.project_id = ?", session[:project].to_i] rescue []
#    end
   
   # copiato paro paro da: http://juixe.com/techknow/index.php/2006/07/09/comments-on-acts-as-commentable/
   # Qualche idea qui: http://juixe.com/techknow/index.php/2006/06/18/acts-as-commentable-plugin/
   def add_comment
     debugger
     commentable_type = params[:commentable][:commentable]     || 'Library'
     commentable_id   = params[:commentable][:commentable_id]  || 1
     # Get the object that you want to comment
     commentable = Comment.find_commentable(commentable_type, commentable_id)

     # Create a comment with the user submitted content
     comment = Comment.new( params[:comment] )
     # Assign this comment to the logged in user
#     comment.user_id = session[:user].id  rescue 1  # da errore
     comment.user_id = current_user.id  rescue 1  # da errore

     # Add the comment
     commentable.comments << comment

#     redirect_to :action => commentable_type.downcase , :id => commentable_id
     redirect_to :controller => commentable_type.downcase.pluralize , :action => commentable_id
   end
   
 end
