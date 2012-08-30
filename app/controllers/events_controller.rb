class EventsController < ApplicationController

  active_scaffold :event do |config|
    list.columns.add :snippet #:creator, :event_type, 
    list.columns.exclude :created_at, :updated_at, :url, 
      :ev_class, :tend , :description, :location, :duration,
      :repeats,
      :price, :private,
      :contact_email, :contact_phone,
      :repeat_frequency, :creator,
      :comments , :tags,
      :summary,  :event_type, :venue #:icon_path,
    config.list.sorting = { :tstart => :asc }
    config.columns[:creator].form_ui = :select
    config.columns[:calendar].form_ui = :select
    list.per_page = 100
  end

  def nexts
    
  end

  def conditions_for_collection
    ['tend > (?)', Time.now() ]
  end

  # def show
  #   @event = Event.find(params[:id])
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @event }
  #     format.ics  { render :ics => @event }
  #     format.text  { render :txt => @event }
  #   end
  # end
  
    # copiato da 'Comments on Acts As Commentable':
    # http://juixe.com/techknow/index.php/2006/07/09/comments-on-acts-as-commentable/
  def add_comment
    commentable_type = params[:commentable][:commentable]
    commentable_id = params[:commentable][:commentable_id]
    # Get the object that you want to comment
    commentable = Comment.find_commentable(commentable_type, commentable_id)

    # Create a comment with the user submitted content
    comment = Comment.new(params[:comment])
    # Assign this comment to the logged in user
    comment.user_id = session[:user].id

    # Add the comment
    commentable.comments << comment

    redirect_to :action => commentable_type.downcase,
      :id => commentable_id
  end
  

end
