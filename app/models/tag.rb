
# puoi mettere i OCLORI delle relationships, tipo:
# friend 40 e infatuato 50 viene fuori ROSA
# friend 50 e infatuato 40 viene fuori orange
# amicizia di solito e' bisenso, affair di solito e' monosenso

class Tag
  attr :name

    # 'mamma' is illegal. Use 'mum' instead.
  @@illegal_tags = {
    :mamma => :mum,
    :dad   => :father,
  }
    # magic dependencies tree.
  @@dependencies = {
    %w{fratello} => :brother,
    %w{mum mamma} => :mother,
    #:brother => :family,
    %w{brother sister mum father grandma grandpa } => :family,
    %w{flirt love ex sex love }  => :affair,  # pink
    %w{bot cli unknown } => :system,
  }
  @@colors = {
    :family => :blue,
    :affair => :pink,
    :work   => :green,
    :friend => :orange,
    :system => :gray
  }

  def initialize(myname)
    @name = myname # Tag.tag_encode(myname) # se lo sanitizzo mi perdo possibili eccezioni, MALE!
    raise "Invalid tag '#{myname}'" unless self.valid?
  end
  
    # "I love you" => "i_love_you"
  def self.tag_encode(tagname)
    tagname.to_s.downcase.gsub(' ','_')
  end

    # "i_love_you"  => "i love you" (case gets lost obviously) 
  def self.tag_decode(tagname)
    tagname.gsub('_',' ')
  end
  
  # va resa efficiente..
  # anzi mi sa che non va..
  def icon
    image_tag( "tags/#{ @name }.png" , :height => 8 )
  end

  def to_s
    "Tag(#{myname.gsub('_',' ')})"
  end

  def self.all
    %w{ prova tags doc dublin fatto da Riccardo vediamo_se_funge }
  end
  
  def self.taggable_models
    [ Person, Friendship, Note , Page , Venue , VenueType , Calendar , Event ]
  end
  
     # for each method I have to do a Find.all e cambiare tags con gsub, direi.
  def self.migrate_all!(old_tag_name, new_tag_name)
    nsaved = { :ok => 0 , :err => 0, :description => [] }
    old_tag_name = old_tag_name.to_s
    new_tag_name = new_tag_name.to_s
    #raise 'ezzoze'
    unless Tag.new(old_tag_name).valid? 
      raise "Source Tag is invalid! '#{old_tag_name}'" 
      return -1
    end
    unless Tag.new(new_tag_name).valid? 
      raise "Dest Tag is invalid! '#{new_tag_name}'"   
      return -2
    end
    Tag.find_all_by_tag(old_tag_name).each{|model,objects|
      objects.each{|obj|
        new_tags = obj.tags.gsub(old_tag_name, new_tag_name)
        puts "TBD: Migra obj #{obj.class}.#{obj.id}. Tags: #{(obj.tags.to_s)} ==> #{new_tags.to_s}"
        obj.tags = new_tags
        if obj.save
          nsaved[:ok] += 1
          nsaved[:description] << "#{obj.class}.#{obj.id} '#{obj}'"
        else
          nsaved[:err] += 1
        end
      }
    }
    nsaved
  end
  
    # per ora diciamo che non deve contenere spazi ne virgole
  def valid?
    self.name.match(/^[a-zA-Z0-9_]+$/)  ? true : false
  end
    
  def find_all_models_by_mytag
     self.find_all_by_tag(name)
  end
  
  def model_find(model)
    self.model_find(name)
  end
  
  def self.model_find(model,tag, limit=1000)
    model.find(:all, :conditions => [ "tags LIKE ?", "%#{tag}%" ] ,  :limit => limit ) rescue []
  end
  
  def find_all()
    self.find_all_by_tag(name)
  end

  def self.find_all_by_tag(tagname)
    ret = {}
    taggable_models.each{|model|
      ret[model.to_s.downcase.to_sym] = model_find(model,tagname)
    }
    ret
  end
  
  #    # TBD removeme
  # def self.test
  #   puts(Tag.find_all_by_tag 'friend')
  #  Tag.migrate_all!('friends', 'friend')
  #  Tag.migrate_all!('colleagues', 'colleague')
  # end
  
end
