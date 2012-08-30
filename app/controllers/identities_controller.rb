class IdentitiesController < ApplicationController
  
  before_filter :login_required
  
  active_scaffold :identity do |config|
    list.per_page = 100
    list.columns.exclude :created_at, :updated_at, :validated, :description, :url, :password
    #list.columns.add :autovalid
    #list.columns.add     :url
    #list.columns[:people].ui_type = :select
    #config.columns[:people].ui_type = :select
    config.columns[:app].form_ui = :select
    config.columns[:person].form_ui = :select
    #config.columns[:name].options = {:include_blank => 'some text', :html_options => {}}
    # See here Ric: config.columns[:name].options = {:include_blank => 'some text', :html_options => {}}
  end

  def contacts
    # TBD
    #@identities = Identity.find_all_by_person_id(2) + #(current_user)
    #    Identity.find_all_by_person_id(1) #(current_user)
    @current_user = current_user
    @current_user_id = current_user.id rescue -1
    @identities = Identity.find_all_by_person_id(current_user.person.id) rescue [] #(current_user)
    @contacts_arrays = @identities.map{|identity|  
      	contacts = (identity.importable? ? 
      #	 Contacts::Gmail.new( identity.login,  identity.password ).contacts :
        Contacts.guess( identity.login,  identity.password ).contacts :
      	  ['Nisba'] 
      	).compact rescue "IdentitiesController Err: #{$!}"
    }
  end
  
  def imported_contacts
    # TBD
    @id = params[:id]
  end
  
  def import_contacts
    @id = params[:id]
    # TBD
  end

  #active_scaffold :users do |config|
  #  # users will no longer be able to create/edit Roles from the Users forms
  #  config.columns[:roles].ui_type = :select
  #end
  


end