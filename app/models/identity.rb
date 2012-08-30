# uid puo essere numero o utente... cio che ti identifica unicamente per un servizio web2.0

#  Identity(id: integer, person_id: integer, app_id: integer, uid: string, description: text, validated: boolean, created_at: datetime, updated_at: datetime)

class Identity < ActiveRecord::Base
  #helpers :all
  searchable_by :uid, :description

  belongs_to :app, :foreign_key => "app_id", :class_name => 'App'
  belongs_to :person, :foreign_key => "person_id", :class_name => 'Person'

#  validates_presence_of :uid
  validates_associated :person, :app
  validates_presence_of :person, :app, :uid

  validates_uniqueness_of :uid, :scope => :app_id, :message => "giappreso per questa appliCAZZONE"
  validates_uniqueness_of :login, :scope => :app_id, 
    :message => "Se lo metti lo devi mettere unico per una certa app... (e in futuro ANCHE per utente!)",
    :allow_blank => true, :allow_nil => true

  def url
    #TBD costruiscimi con servizio + mio uid: #{uid}"
    build_link
  end

  def name
    uid
  end

  def to_s
    uid
  end

  # intelligent
  def build_link
#    "(#{app.local_path} ; uid )" rescue "Err: $!"
    app.local_path.gsub('___UID___',uid ) rescue "Err: $!"
  end

  def to_label2
#    "ICONA_link(#{url},#{uid})"
 #   IdentitiesHelper::url_column(self)
    "icona"
    #r=self
    #link_to( " app_column(r)", r.build_link, :target => '_blank') rescue "Link error: #{$!}"
  end
  
#  def nullify
#  end
  def importable?
    (
      validated &&
      login.to_s.length > 0 &&
      password.to_s.length > 0 &&
      defined?(app) && 
       %w{ hotmail gmail msn yahoo }.include?( app.name.downcase )
    ) rescue false
  end
#  def self.destroy # person
#    throw "lo implementero in futuro... per ora ciccia"
    #account = Account.find(foo)
    #account.variety.delete(params[:id])
    #redirect_to :action => 'edit', :id => foo
#  end

  
end
