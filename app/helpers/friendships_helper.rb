module FriendshipsHelper
  
  def to_html(f,imgsize = 15)
    two_people = [ f.follower, f.followed ]
    link_to( model_img(imgsize), f )+
      two_people.map{|p| link_to(p,p) }.join(" =&gt; ")
  end
  
  def model_img(h=15)
    image_tag( 'models/friendship.png', :height => h, :border => 0)
  end
  
  def reciprocated_column(r)
    rec = r.reciprocated 
    r.reciprocated? ? 
      link_to( image_tag( 'icons/stars/yellow.png', :height => 15, :border => 0) , rec, :border => 0) : 
      new_friendship_fancy_link(r.followed,r.follower,"Not reciprocated, create reciprocated friendship!", 'reciprocated :)') 
  end
  
  def new_friendship_fancy_link(person1, person2, msg = nil, notes = '')
    msg ||= "'New followhip for #{person1} to  #{person2}"
    link_to( image_tag('models/friendship.png', :height => 25, :border => 0) + msg, 
			:controller  => :friendships , 
			:action      => "new", 
			:person_id   => (person1.id rescue 3142),
			:followed_id => (person2.id rescue 3242), 
			:tags        => 'friends', 
			:notes        => notes,
			:importance => 28,
			:align => 'right'
		)     
  end
  
end
