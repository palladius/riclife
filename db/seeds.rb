# This file should contain all the record creation needed to seed the database with its default values.
#
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

 #script/generate scaffold -c app name:string description:text host_id:integer url:string
 # db_uri:string local_path:string svn_uri:string language:string


require 'open-uri'
 
##########################################################################################
### CONF DATA
@arr_event_types = [
  'gig', 'concert', 'opera', 'theater',               # music
  'dinner', 'party', 'birthday party',     #  partying
  'meeting', 'job travel', 'conference',   # work
  'trip' , '', 'trip'   # travels
]
@arr_hosts = [ 'dev.palladius.eu', 'slartibartfast.heanet.ie' ]
### CONF DATA
##########################################################################################



	# lo costruisce se NON esiste!!!
#@arr_hosts.each do |hostname|
#	Host.find_or_create_by_name(hostname)
#end

# Apps have changed since...
# # Should create facebook and stuff
# App.create(
#   :name => 'riclife',
#   :description => 'This application itself! My pangea container for Riccardo life on Rails!',
#   :host_id => Host.find_by_name('dev.palladius.eu'),
#   :url => 'http://dev.palladius.eu/to/be/decided/yet/the/main/path',
#   :db_uri => 'dburi://riccardo@dev:database/tables',
#   :local_path => '/var/www/capistrano/riclife/',
#   :svn_uri => 'svn+ssh://riccardo@svn.goliardia.it/var/svn/ricdev/projects/riclife',
#   :language => 'rails'
# )

#Scopiazzato da railcasts 179

# Crea modello Country (name, code string 2)
#IT|Italy
#JM|Jamaica
#JP|Japan
Country.delete_all
# se dovessero toglierlo, o cambiarlo, l'ho messo su "tmp/country_code_drupal_0.txt"
open("http://openconcept.ca/sites/openconcept.ca/files/country_code_drupal_0.txt") do |countries| 
	countries.read.each_line do |country|
		code,name = country.chomp.split '|'
		Country.create!(:name => name, :code => code)
	end
end


@arr_event_types.each { |et | 	EventType.dflt_create( et ) }

#foreach user
  # create 2 calendars: personal (priv) and public (pub)
  # whenever you create a new user, trigger this func!

#  1. Create users  
User.create(
  :login => 'riclife',
  :password => '126tfshqNnTbq4br4',
  :password_confirmation => '126tfshqNnTbq4br4',
  :email => 'riclife@gmail.com' )
  

Page.create( 
  :title => 'Help', 
  :abstract => "This page helps you districate through all these crazy things Riccardo did!"
)

%w{ ferrara bologna dublino }.each{|city|
  City.create(
    :nomecitta => city,
    :sigla => city[0..1],
    :regione => "Emilia-Romagna"
  )
}
