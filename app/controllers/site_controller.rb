# Generated thru:
# $ script/generate controller Site index docs rss

class SiteController < ApplicationController
  helper :auth 
  include AuthenticatedSystem
    helper TagsHelper, PeopleHelper
  
  # before filter @you=current_user
   
  def index
    #@venue = Venue.new
    #@person = Person.find(params[:id])
    #@person = current_user.person rescue Person.last # inutile nel index lo devi cmq passare al partial...
  end

  def docs
  end

  def rss
  end
  
  def gcontacts
  end

  def wall
    @you = current_user # get_user
  end

  def search
    @query_string = params[:q] || ""
  end

end
