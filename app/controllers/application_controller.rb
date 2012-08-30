  # $Id: application_controller.rb 1684 2010-08-03 07:46:51Z riccardo $
class ApplicationController < ActionController::Base
  helper :strings, :gmaps
  helper :auth # da' primitive come get_user e current_person
  helper :layout
  include GmapsHelper  # TBD mettilo *solo* dove serve (costa molto)
  helper WikiHelper
  include AuthenticatedSystem
  helper TagsHelper
  helper GeoipHelper
#  include ExceptionNotifiable

    # così tutti hanno il login obbligatorio, vediamo se non mi incula le sessioni però.
  before_filter :login_required
  
#   helper ColorsHelper
#   helper GmapsHelper
  helper ColorsHelper, GmapsHelper
  helper ArraysHelper
  helper StringsHelper
  helper PeopleHelper
  
  before_filter :populate_all_tags
    
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

	# copied from here: http://blog.codefront.net/2007/12/10/declarative-exception-handling-in-your-controllers-rails-20-a-feature-a-day-2/
	# seems really cool!
  # rescue_from ActiveRecord::RecordInvalid do |exception|
  #   render :action => (exception.record.new_record? ? :new : :edit)
  # end

  ###### ExceptionNotifier
  # see: http://rails.brentsowers.com/2008/01/exceptionnotification-plugin-for.html
  #include ExceptionNotifiable
  #consider_local "193.1.219.0/24", # heanet
  #  "193.1.228.215" ,  # eccentrica
  #  "193.1.228.252"    # slarti
    
  #@you = current_user # get_user from auth socmel

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  # copiato da: http://snippets.dzone.com/posts/show/1799
  def richelp
  	Helper.instance
  end
  
  class Helper
  	include Singleton
  	#include ActionView::Helpers::NumberHelper
  	#include ApplicationHelper
  	include GmapsHelper
  end

  ################################################################################################################################
  # PROTECTED CODE
  ################################################################################################################################
protected
    def invalidate_cache(page_to_invalidate = "/friendships/update_dotsvg")
      begin
        #caches_page :index , :update_dotsvg  # cache la foto
        expire_page( page_to_invalidate ) # "/friendships/update_dotsvg"
        expire_page "/friendships/update_dotsvg"
        expire_page :action => :update_dotsvg
        #expire_page "/friendships/index"
        #expire_page :index
        flash[:notice] = " {{Cache for page '#{page_to_invalidate}' invalidated}}"
      rescue
        flash[:error] = " {{invalidate_cache for page '#{page_to_invalidate}' exception: '#{$!}'}}"
      end
    end
    
      # Popola tutti i tags AD OGNI PAGINA: dovrei almeno cacharla cristo!
      # TBOPT cacha sti cacchio di tags..
    def populate_all_tags(models = nil)
      unless logged_in?
        @all_weighted_tags = [ ['no_tags_cos_youre_logged_out', 42] ]
        return
      end
      models = Tag.taggable_models unless models
      aa_tags = []
      models.each{ |model|
        # TODO crea una query .visible() che dà per utente X le cose che X puo vedere..
        aa_tags << model.find(:all).map{|x| x.tags rescue nil }.join(' ').gsub(',',' ').split(' ') # .sort
      }
      all_tags = aa_tags.flatten
        # dà un array di arrays... qindi serve il flatten
      @all_tags = all_tags.uniq
      @all_weighted_tags =  all_tags.sort.uniq_c.sort
    end
      
private
  # copiato da episodio 127
  def call_rake(task, options ={} )
    options[:rails_env] = Rails.env
    args = options.map { |k,v| "#{k.to_s.upcase}='#{v}" }
    system "/usr/bin/rake #{task} #{args.join(' ')} --trace >>#{Rails.root}/log/call_rake_verboso.log &"
  end

end