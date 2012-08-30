
=begin
  fighissimo, è polimorfico...
  peccato che sia in vendor :-((()))
  
=end
class Comment < ActiveRecord::Base
  searchable_by :title, :body
  @@description = <<-FINE
  'Comment is my first poymorphic class. It comments everything based on the polymorphic association given by
   ({commentable_type} {commentable_id}")
   Quindi ci puoi commentare di tutto...
  FINE
  validates_presence_of :title, :message => "can't be blank"
  
  # TBD DRY this, come cacchio si fa?!?
  COMMENT_VALID_TYPES = Object.subclasses_of(ActiveRecord::Base).sort{|x,y| x.to_s <=> y.to_s} -
  [ Comment , Recipe ]
=begin
  COMMENT_VALID_TYPES =  ApplicationHelper::ALL_MODELS rescue %w{ 
      App Calendar City Comment Country EventAttendeet EventAttendee EventType
      Friendship Gms Group Host Ical Identity Keyval Loan MagicUrl Mailing
      Note Person Photo Project Recipe RicEvent User Venue VenueType 
  } 
=end
  validates_numericality_of :commentable_id, :greater_than_or_equal_to => 1  # se dai stringhe o cagate da ZERO, cosi ti assicuri che sia valido!

##    # mi da errore, credo che lo faccia da oslo il chk...
##  #  validates_inclusion_of :commentable_type, :in => COMMENT_VALID_TYPES , :message => "must belong to known model, checcachio: #{COMMENT_VALID_TYPES.join(', ')}"

  def name
    title
  end
  
  def to_s
    title
  end
  
  def to_label
    title
  end
  
  # def user
  #   User.find(user_id) rescue nil
  # end
  
  def poly_link
    "<a href='/#{commentable_type.pluralize.downcase}/#{commentable_id}'>#{commentable_name}</a>\n"
  end
  
  def commentable_name
    "#{commentable_type} ##{commentable_id}"
  end
  
  def self.commentable_types
    COMMENT_VALID_TYPES
  end
  
  
  #def title: attento sembra che l abbiano immplementato come PRIVATE!
  
#end
# original
#class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  
  # NOTE: install the acts_as_votable plugin if you 
  # want user to vote on the quality of comments.
  #acts_as_voteable
  
  # NOTE: Comments belong to a user
  belongs_to :user


		# CARLESSO_BEGIN
	def to_s()
		 title
	end
	def to_label()
	  title
  end
		# CARLESSO_END
  
  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  def self.find_comments_by_user(user)
    find(:all,
      :conditions => ["user_id = ?", user.id],
      :order => "created_at DESC"
    )
  end
  
  # Helper class method to look up all comments for 
  # commentable class name and commentable id.
  def self.find_comments_for_commentable(commentable_str, commentable_id)
    find(:all,
      :conditions => ["commentable_type = ? and commentable_id = ?", commentable_str, commentable_id],
      :order => "created_at DESC"
    )
  end
  
  def self.description
    @@description
  end

  # Helper class method to look up a commentable object
  # given the commentable class name and id 
  def self.find_commentable(commentable_str, commentable_id)
    logger.warn( ( [commentable_str, commentable_id].inspect ) )
    commentable_str ||= 'Event'
    commentable_str.constantize.find(commentable_id)
  end
end

