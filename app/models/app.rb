class App < ActiveRecord::Base

  searchable_by :name, :url, :description

  validates_presence_of :name, :icon
  validates_uniqueness_of :name

  validates_format_of :local_path, :with => /___UID___/,
    :message  => " must contain a ___UID___ to be substituted with id.."

  has_many :identities,  :foreign_key => "app_id" , :class_name => 'Identity'  #, :dependent => true
  has_many :people, :through => :identities #, :class_name => 'Person'
  #has_and_belongs_to_many :people, :join_table => 'identities'

  def to_s
    name
  end

  def to_label
    to_s
  end

  #def icon
  #  'twitter.png'
  #end

 # def nullify # person
 #    throw "lo implementero in futuro... per ora ciccia"
 #    #account = Account.find(foo)
 #    #account.variety.delete(params[:id])
 #    #redirect_to :action => 'edit', :id => foo
 #  end

 def app_url
   url
 end


end
