class Friendship < ActiveRecord::Base
  belongs_to :followed, :foreign_key => 'followed_id' , :class_name => 'Person'
  belongs_to :person # youre the follower
  
  searchable_by :notes, :tags
  
  validates_presence_of   :person, :followed
  validates_uniqueness_of :followed_id, :scope => :person_id
  
  def to_s
    "#{person rescue "_UNKNOWN_FOLLOWER_"} -> #{followed rescue "_UNKNOWN_FOLLOWED_"}" #rescue " nil"
  end
  
  alias :name :to_s
  alias to_label :to_s
  
  alias :follower :person
  
  # to be removed
  def self.followerz(person)
    find_all_by_followed_id(person.id).map{|p| p.followed} 
  end
  def self.followeds(person)
    find_all_by_person_id(person.id).map{|p| p.name} # .join(', ')
  end
  def self.friends(person)
    #    followers(person) && followeds(person)
    followers(person) & followeds(person)
  end
  
  def reciprocated?
    #true
    Friendship.find_by_person_id_and_followed_id(followed_id,person_id) 
      # :person_id    => self.followed_id ,
      # :followed_id  => self.person_id 
      # )
  end
  alias :reciprocated :reciprocated?
  
    # colors them based on the tag
  def dot_color()
    tagz = tags.to_s rescue ''
    return 'purple'  if tagz.match(/family|sister|ther|dad|mum|grand|son|figli|brother|fratell|sorell|married|spouse|wife|husband/)
    return 'red'     if tagz.match(/love|amore|sex|spos|marr|wife|husband|ama|kiss/)
    return 'pink'    if tagz.match(/fancy|like|fancies|ex/)
    return 'green'   if tagz.match /work|job|colle|boss|slave/
    return 'orange'  if tagz.match /goliard/
    return 'blue'    if tagz.match /sport|job|marat/
    return 'yellow'  if tagz.match /friend|amic/
    return 'gray'    # dunno
  end
  
  # rbellosi  [label="Ridge turing PNG", shape=box, color=black, image="web20/Turing.png" ];
  def to_dot()
    return "nisba ;" unless self.person && self.followed
    src  = person.dot_nickname  rescue "PersonaIgnota: #{$!}" # nickname.to_s.gsub(/[ \']/,'_') # subsitutte with "dot_nickname"
    sink = followed.nickname.to_s.gsub(/[ \']/,'_') rescue "SinkIgnoto per friend.id=#{id}: #{$!}"
    penwidth = [((importance - 20) / 20) , 1 ].max rescue 10;  # 30 che e default deve fare 1 o al max 2..
    my_label = ''
    my_label = notes unless notes.match(/DEBUG/) rescue ''
    dot_opts = {
      :label => my_label,
      :penwidth => penwidth,
      :fontsize => 9,
      :tooltip => "Tultip for '#{my_label}' (importance=#{importance})\nTAGS22: #{self.tags}",
      :color   => dot_color(),
      #:headlabel => my_label, #'headlabel',
      #:style => ' color: red; font-size: xx-small ',
      #:fillcolor => 'red',
      :URL => "/friendships/#{id}/edit",
      :target => '_blank',
    }
    " #{src} -> #{sink}  [" + dot_key_values(dot_opts) + "]" rescue "Friendship.to_dot(#{self}) Exception: #{$!}"
  end
  alias :dot :to_dot
  
  def graphable?(minimum_graphability = 15)
    return false if( importance < minimum_graphability )
    (person.graphable? && followed.graphable?) rescue true
  end
  
    # says if they are DIRECT family members
    # checks if tags contains 'son, grandson, wife, husband, ...'
  def relative?
    tags.match(/son|daughter|wife|husband|family/) rescue false
  end
  
  def self.to_dot(graph_name)
    graph_name = graph_name.to_s.to_sym
    if graph_name == :update_dotsvg # horrible name I know!
      return [ "digraph G_friendship_#{graph_name} {", 
       Person.all.map{|f| f.to_dot if f.graphable? rescue "'FriendS2Err_for_'#{f}':_''#{$!}'"  }.compact , 
       Friendship.all.map{|f| f.to_dot if f.graphable? rescue "\"FriendS1Err_for_#{f}_#{$!}\"" }.compact , 
      "}"
    ].join("\n") # rescue " digraph G_erore2 { ECCEZZZIONE -- 'Friendship.to_Dot' -- '#{ ($!.to_s).gsub(/[\'\n ]/,'_') }' } "
    end
    if graph_name == :family # horrible name I know!
      return [ 
        "digraph G_friendship_#{graph_name} {", 
        Person.all.map{|f| f.to_dot if f.graphable? rescue "FriendS2Err for '#{f}': ''#{$!}''"  }.compact , 
        Friendship.all.map{|f| f.to_dot if f.graphable?(15) and f.relative?() rescue "FriendS1Err for '#{f}': ''#{$!}''" }.compact , 
        "}"
      ].join("\n") rescue " digraph G_erore_#{graph_name} { ECCEZZZIONE -- 'Friendship.to_Dot' -- '#{ ($!.to_s).gsub(/[\'\n ]/,'_') }' } "
    end
    raise "Unknown graph name: ''#{graph_name}''"
    return nil
  end
  
  def self.foo
    'bar'
  end
  
  
end
