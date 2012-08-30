# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  #require 'LayoutHelper'
  #require 'TagsHelper'
  #require 'ColorsHelper'
  include ColorsHelper

		# vanno ma non li voglio vedere:
	SCHIFUZ_MODELS = %w{ libraries hosts countries }
	ACTIVESCAFFOLDABLE_MODELS = [ Person, Friendship, Note ] # note non lo è ancora, è una prova ;)
  ICON_PATH_HEIGHT  = 45
  ICONS_SIZE = 15
  ACTION_ICONS_SIZE = 12
  IMAGE_HEIGHT  = 45  # REMOVE ME (aggrega a con path height)
  
  COMMENTABLE_MODELS = [ 
    Event, EventAttendee, Gms, Host, Loan, Person, Venue 
  ] # TBD check che consistente con 
    # rrgrep acts_as_commentable app/models/*rb

  MINOR_MODELS = [ City, Country, Group, Keyval, Library, Mailing, 
    Photo, PhotoType, Calendar, Comment, 
    Event, EventType, EventAttendee, 
    Recipe , Host , User , RicEvent 
  ]
  ADD_MODELS = [  ] # Models who arent on app/models/ but you want as major ones, for example act_as_somthingable
  Dir.glob(RAILS_ROOT + '/app/models/*.rb').each { |file| require file }
  
  # sort by name..
  ALL_MODELS = Object.subclasses_of(ActiveRecord::Base).sort{|x,y| x.to_s <=> y.to_s}
  HEADER_MODELS  = (ALL_MODELS + ADD_MODELS - MINOR_MODELS)
  UNSEARCHABLE_MODELS = [ Photo, PhotoType ]   # to be implemented yet TBIY

   # rendered by header_link()
   MULTI_MENU = {
     :bookmarkz => [
       ['icons/home.png', "Home" , "/" ],
       ['models/person.png', "As::People" , "/as/people" ],
       ['icons/home.png', "Tests" , "/site/test" ],
       ['models/identity.png', "Imported Contacts" , "/identities/contacts" ],
       ['icons/graph.png', "Graph Friendships Page" , "/friendships/graph" ],
       ['icons/graph.png', "Graph SVG" , "/friendships/update_dotsvg" ], # http://riclife.local/friendships/update_dotsvg
       ['icons/graph.png', "Graph Graph Page" , "/graphs/" ],
       ['apps/facebook.png', "Wall" , "/site/wall" ],
       ['apps/gmail.png', "GContacts" , "/site/gcontacts" ],
       ['models/event.png', "iCal" , "/ical/competitions" ],
      # ['icons/chat.jpg', "Chat TBD" , "/site/chat.html" ],
       ['models/import.png', "Importer" , "/importer/" ],
       ['icons/home.png', "Pal" , "http://www.palladius.it/" ],
     ],
     :gmaps => [
       ['gmaps/globe.png', "Maps/" , "/gmaps/" ],
       ['gmaps/globe.png', "GVenues" , "/venues/gmap" ],
       ['gmaps/globe.png', "GEvents" ,    "/calendars/gmap" ],
       ['gmaps/globe.png', "GPeople" , "/people/gmap" ],
       # [ 'models/venue_type.png', "VenueTypez", "/venue_types/" ]
     ],
     :admin => [
         ['models/admin.png', "Admin" , "/admin/" ],
         ['models/person.png', "As::People" , "/as/people" ],
      ],
=begin
      :login => [
          ['icons/login.png', "SignUp" , "/signup" ],
          ['icons/login.png', "Login" ,  "/login" ],
          ['icons/login.png', "Logout" ,  "/logout" ],
       ],
=end
   }

  RICLIFE_VER = "1.2.005"
  RICLIFE_DESC = <<-RICLIFE_DESC_END 
  #{RICLIFE_VER}
    Aggiunte venues e venuetypes. GeoFigata.  note polimorfica
    Eventi e tipi di evento, upload foto... insoma una figata!!!

    Le mappe fungono!!!
    
    Migrato Inetor gperson a Person finalmente...
    
    Il login funziona, si vede dai GMS
  RICLIFE_DESC_END
  
  def todo(str='')
    image_tag("carlesso/icons/bug.png", :size => "20x20") + " <b>TODO</b>#{str}"
  end
  
  def heanet?
    #host != 'hansel'
    Socket.gethostname.match( /slartibartfast/ )
    #true # basati sull'IP sorgente... = 127 oppure 193 e rotti
  end
  
  def get_icon_environment(subdir="rails", height=30 )
    env=  ENV["RAILS_ENV"]
    image_tag "icons/environment/#{subdir}/#{env}.png", :height => height , 
#  	  :align => "left", 
  	  :alt => "Environment type: #{env} PAZ=icons/environment/#{subdir}/#{env}.png"
  end

  # copiato da AdvancedRailsRecipes pag 26
  def toggle_value(obj)
    remote_function(
      :url => url_for(obj),
      :method => :put ,
      :before => "Element.show('spinner-#{object.id}'",
      :after  => "Element.hide('spinner-#{object.id}'",
      :with   => "this.name + '=' + this.checked"
    )
  end
  
    # Questo crea un HTML javascript che è toggabile con APRI CHIUDI :)
    # e yielda :)
  def toggable_box(div_id ,start_visible = true)
    return <<-TOGGABLE_END
    
    <!-- toggable Ric con id= -->
  
    AAA
    <a href="#" onclick="Element.toggle('#{div_id}')">Togglami!</a>
    BBB
    <div id="#{div_id}" style="display:none;" >
    	<h2>toggable_box(#{div_id})</h2>
    #{link_to_function("link", "Element.hide('#{div_id}');") }  
    <h2>prova1</h2>
      #{yield}
    <h2>prova2 debug</h2>
      #{yield}
    </div>
    
    
    TOGGABLE_END
  end
  def h2(s)
    "<h2>#{s}</h2>"
  end
  def toggable_box_noyield(div_id ,content, start_visible = true)
    toggable_box_begin(div_id , start_visible) +
      content + 
    toggable_box_end(div_id , start_visible)
  end

  def toggable_box_begin(div_id , start_visible = true)
    image_opts = { :height => 35 , :label => "Toggle div#id=#{div_id}"  }
    style_invisible = ' style="display:none;" '
    "<a href=\"#\" onclick=\"Element.toggle('#{div_id}')\" >
      #{ image_tag('widgets/book-open.png', image_opts) }
    </a>
    <div id=\"#{div_id}\"  #{style_invisible unless start_visible } >" +
      image_tag('widgets/book-closed.png', image_opts ) 
      #h2("toggable_box(#{div_id})") +
      #link_to_function("Nascondi link", "Element.hide('#{div_id}');") +
  end
  # 	<a href="#" onclick="Element.toggle('box4')">Toggle BOX4 </a>
  def toggable_box_end(div_id='dont matter...' , start_visible = true)
    "</div>"
  end
  
  # due alias :)
  def user()
    get_user
  end

  def local_request?
    false #true
    #request.remote_ip.to_s.match /127.0.0.1|::1/
    # Socket.gethostname.match /hansel|slartibartfast/
    #request.env["REMOTE_ADDR"] # local == ::1 or 127.0.0.1
  end
  
  def edit_column(r, mylabel=nil)
    mylabel ||= "Edit '#{r}'"
    link_to( mylabel, { :action => "edit", :id => r.id }, :method => :get)    
  end

  def get_photo()
    image_tag "public/images/carlesso/persone/#{get_user}.jpg" # TBD
  end
  
  def multi_header_links(multimenu)
    multimenu.map do |title,arr|
      header_links(title,arr)
    end
  end

  def header_links(title,arr_links,opts={})
    @title_tag = 'b'
    ret = "<div class='header_left' align='left' >\n"
    ret << "<br/><#{@title_tag} class='header_title' >#{title.to_s.capitalize}</#{@title_tag}><br/>"
    ret << arr_links.map{ |m|
      icon,name,lnk = m[0], m[1], m[2]
      (opts[:auto_add]   ? link_to( icon('icons/add.png') , "#{lnk}new?_method=get" ) : '' )+
      (opts[:auto_first] ? link_to( icon('icons/1') , "#{lnk}1" ) : '' )+
      link_to( image_tag(icon, :width => 15 , :border => 0) + " #{name}" , lnk )
    }.join('<br/>')
    ret << "</div>"
    #ret
  end
  
  def log
    logger.info
  end

  def header_models(title,arr_models)
    # devo returnare coppie icona/modello per darlo in pasto al precedente...
    #@title_tag = 'b'
    arr_links = arr_models.map { |m| # i.e. VenueType
      modelname = m.to_s.downcase             # "venuetype"
      models = modelname.pluralize
      mtabs = m.to_s.tableize  # like: 'venue_types'
      [
        "models/#{mtabs.singularize}.png" ,
         m.to_s.pluralize ,
         "/#{mtabs}/"
      ]
    }
    header_links(title,arr_links, :auto_add => true , :auto_first => true )
  end

  def header_banner(url = "carlesso/RicLogoLargoDublino2009.jpg" )
    link_to(
      image_tag( url, 
        :alt => 'RicLife Header',
        :width => 600, :height=> 100),
      '/',
      :border => 0
      ) unless heanet?
  end

  # io la deprecherei e andrei giu di OPZIONI per integrabilita..
  def user_icon()
    photo_name_column(get_person, 65)
  end
  
  def table(str,border=1)
    "<table border='#{border}'><tr><td>#{str}</td></tr></table>\n"
  end
  
  def devel(str)
    table("devel(): " + str) 
  end

  # renders automagicamente un'icona, se locale come locale, se no come remota.
  # greppando la regex. Dobrevve supportare pure gli upload in futuro... speriamo.
  # If (class=App, "aaa.jpg") (no /)
  # Normalmente funzioan cosi:
  #  image_path("edit")                                         # => /images/edit
  #  image_path("edit.png")                                     # => /images/edit.png
  #  image_path("icons/edit.png")                               # => /images/icons/edit.png
  #  image_path("/icons/edit.png")                              # => /icons/edit.png
  #  image_path("http://www.railsapplication.com/img/edit.png") # => http://www.railsapplication.com/img/edit.png
  def link_google_images(obj)
    link_to "GglImg", "http://images.google.com/images?q=#{obj.name}", :target => '_blank'
  end

  def magic_path(r, icon_field = 'icon_path', height = nil, opts = {})
    paz = r.send(icon_field) 
    return nil if paz == ''
#    return paz if (paz =~ %r{^/} )
    return paz if (paz =~ %r{^http|^/} ) # lascio com'e'
    return "/images/#{paz}" if (paz =~ %r{/} )   # se ha slash ma non INIZIA con slash (tipo gmaps/aaa.png ) basta agiungere un /images/
    return "/images/#{r.class.to_s.tableize}/#{paz}" # casino, autodetect da modello :)
  end
  
    # TBD implementa logica che se non lo trovi per la venue lo cerchi nel venuetype e cosi via (posto lavoro ric -> fotoric)
  def icon_magic(r, icon_field = 'icon_path', height = nil, opts = {} )
    height ||= ICON_PATH_HEIGHT
    begin
      paz = r.send(icon_field) # || "nil.png"
      return link_google_images(r) if paz.nil?
      return '(empty)'   if paz == ''
        # se non contiene slash devo aggiungeregli il modello
      if (paz =~ /\// )
        iconpaz = paz    # tengo http://whatever or "/icons/sodoveandare/immagine.png"
      else # locale ci prependo il 'apps/' o whatever
        iconpaz = "/images/#{r.class.to_s.tableize}/#{paz}"
      end
      link_path = opts[:link] || iconpaz
      return link_to( image_tag(iconpaz , :height => height , :border => 0), link_path ) 
    rescue
      "IconMagic Err w/ photo (model=#{r.class},field=#{icon_field}): #{$!}"
    end
  end

  def logga(str, severity = 'warn' )
    logger.warn(yellow(str)) # severoty TBD
  end

  # preso da ruby sushi pag 26
  def toggle_value(object,field) # = 'boh' )
    logga("toggle_value(#{object})")
    remote_function(:url      => url_for(object), 
                    :method   => :put, 
                    :before   => "Element.show('spinner-#{field}-#{object.id}')", 
                    :complete => "Element.hide('spinner-#{field}-#{object.id}')",
                    :with     => "this.name + '=' + this.checked")
  end

  def togglable_checkbox(model,field, title = '')
    cls = model.class.to_s.downcase
    "<strong>#{title}</strong>" +
      check_box_tag( "#{cls}[#{field}]", "1", model.send(field), :onclick => toggle_value(model,field) )+
      image_tag( 'spinner.gif', :id => "spinner-#{field}-#{model.id}", :style => 'display: none' ) 
    #{}")"
  end

  # non posso migrarlo su inetorg, porca pupazza..
  def photo_name_column(r, height=nil, icon_field = 'photo') #, opts ={})
    icon_magic(r, icon_field, height, :link => r)
  end
  
  def valid_column(r)
    r.valid? ? '' : link_to(image_tag('icons/warning.png' , :size => '25x25', :border =>0 ), 
      { :action => "edit", :id => r } ) #, :method => :put   )
  end
  
  def autovalid_column(r)
    valid_column(r) rescue "AutoValid Exception: #{$!}"
  end

  def icon_path_column(r)
    #link_to(image_tag( r.icon_path , :height => IMAGE_HEIGHT ), r.icon_path ) if r.icon_path
    icon_magic(r)
  end

  def active_column(r)
    #image_tag( r.active ? "icons/dialog-apply.png" : "icons/delete.png", :size =>  '20x20' )
    boolean_icon r.active
  end
  def main_column(r)
    boolean_icon(r.main)
  end
  def boolean_icon(bool)
     #{}"bool=#{bool}" + 
      image_tag( bool ? "icons/dialog-apply.png" : "icons/delete.png", :size =>  '20x20' )
  end
  
  def color_table(color,content)
    "<table bgcolor='#{color}'  ><tr  ><td  width='10' height='10' >#{content}</td></tr></table>"    
  end
  # http://www.w3schools.com/HTML/html_colornames.asp
  def color_column(r)
    content = "<font color='#{ r.color rescue 'red' }' >#{ r.color rescue "ColorErr: #{$!} "}</font>" 
    color_table( r.color ,content)
  end
  def todo_column(r)
    r.todo ?
      image_tag(  "icons/todo.png", :size =>  '20x20' ) :
      '' # image_tag("icons/dialog-apply.png", :size =>  '20x20' )
  end
    def name_surname_column(r)
      link_to( "<font class='person #{sexclass(r.male)}'><b>#{r.name_surname}</b></font>", r ) rescue 'err N_S'
    end

  def app_column(r)
    #image_tag("apps/#{r.app.icon}", :size => '20x20', :border => 0 ) + "bug?"
    icon_magic(r.app,'icon',15)
  end

  #   # questo sembra aver senso solo per le app..
  # def url_column(r)
   #   link_to( app_column(r), r.build_link, :target => '_blank') rescue "AppHelper:UrlColumn(), Link error: #{$!}"
   # end
   def dflt_url_column(r)
       link_to( r.url, r.url, :target => '_blank') rescue "AppHelper:DfltUrlColumn(), Link error: #{$!}"
   end

  def private_column(r)
    image_tag( "icons/private.png", :height => ICONS_SIZE ) if r.private
  end
  
  #   # tags: barra colorata
  # def coloured_bar_test
  #   %q{
  #   <div style="border: 1px solid black; height: 10px; width: 108px; background-color: lightgray">
  #     <div style="float: left; height: 10px; width: 30px; background-color: red;"></div>
  #     <div style="float: left; height: 10px; width: 15px; background-color: yellow;"></div>
  #     <div style="float: left; height: 10px; width: 63px; background-color: green;"></div>
  #   </div>
  #   }
  # end
  def coloured_bar(green_qty=nil,red_qty=nil,yellow_qty=nil, label = nil)
    green_qty ||= 66
    red_qty   ||= (100 - green_qty )
    yellow_qty ||= 0
    height = 15
    label ||= "TestLalabel"
    sum = red_qty + green_qty + yellow_qty 
    #coloured_bar_test + 'asd' +
    "<div style='border: 1px solid black; height: 10px; width: #{sum}px; background-color: lightgray' >
      <div style='float: left; height: 10px; width: #{red_qty}px; background-color: red;' label='red quantity: #{red_qty}'>#{label}</div>
      <div style='float: left; height: 10px; width: #{yellow_qty}px; background-color: yellow;' > </div>
      <div style='float: left; height: 10px; width: #{green_qty}px; background-color: green;' > </div>
     </div>"
  end

  def yesno(bool_var) # html
    return '??'.tag('font', :color => 'gray') if bool_var.nil?
    bool_var ?
      'ok'.tag('font', :color => 'green' ) :
      'no'.tag('font', :color => 'red' )
  end
  
  def to_html(r)
    #link_to(r.to_s + ".to_html()", r ).tag('span', :class => r.class.to_s.downcase)
    r.to_s.tag('span', :class => r.class.to_s.downcase)
  end

  # def tag(tagname, content)
  #     "<#{tagname}>#{content}</#{tagname}>\n"
  #   end

  def action_icon(action='edit')
    # legals are: edit, add, delete, view
    image_tag( "icons/#{action}.png", :width => ACTION_ICONS_SIZE, :height => ACTION_ICONS_SIZE, :border => 0)
  end
  def icon(paz, opts={} )
    paz = "#{paz}.png" unless paz.match /\./
    opts[:width]  ||= ICONS_SIZE unless opts[:height] # non riesco a fare il viceversa purtroppo  ameno che non usi una var tmp.. ma tanto non succederà mai che metto la width e nonl a height :)
    opts[:height] ||= ICONS_SIZE
    opts[:border] ||= 0
#    image_tag( paz, :width => ICONS_SIZE, :height => ICONS_SIZE, :border => 0)
    image_tag( paz, opts) # :width => ICONS_SIZE, :height => ICONS_SIZE, :border => 0)
  end
  
  # Create  - Add
  # Read    - View
  # Update  - Edit
  # Delete  - X/destroy
  # Index   
  # Back
  # Home
  ### --> "ABCDEHIRUVX" usate
  def magic_links(model, options = 'crudhib', opts = {} )
    separator = ' '
    verbose = opts.fetch(:verbose, false   ) #!= false
    lnks = %( <span class="magic_links" ><small>\n )
    lnks += link_to( icon('icons/add')   + (verbose ? "Add new #{model.class}"  : ''), :action => "new" ) + separator  if options.match( /[ac]/i )
    lnks += link_to( icon('icons/edit')  + (verbose ? "Edit #{model}"           : ''), edit_polymorphic_path(model) ) + separator rescue "ML_Exc(Edit #{model})" if options.match( /[ue]/i )
    lnks += link_to( icon('icons/delete')+ (verbose ? "Delete #{model}"         : ''), model, :confirm => 'Are you sure?', :method => :delete ) + separator  if options.match( /[xd]/i )
    lnks += link_to( icon('icons/schema')+ (verbose ? "Index for #{model.class}": ''), model, :action => "index" ) + separator if options.match( /i/i )
    lnks += link_to( icon('icons/back')  + (verbose ? "Back to previous page"   : ''), url_for( :back ) ) + separator if options.match( /b/i )
    lnks += link_to( icon('icons/home2') + (verbose ? "Home for RicLife"        : ''), '/' ) + separator if options.match( /h/i )
    #lnks += "ESPERIMENTO (((#{url_for(model.class.new)} , #{url_for(Gms)})))"
    lnks += '</small></span>'
    return lnks
  end
  
  def pre_exception(desc,err)
    %(<b class='debug' >#{desc} Exception</b>: <pre>#{h $!.to_s}</pre>\n)
  end
  
  def fancy_model(obj, label=nil)
    mylabel ||= obj.to_s.capitalize
    mylabel = 'nil' if obj.nil?
    singular_class = obj ?  obj.class.to_s.downcase.singularize : 'nil' 
    img = image_tag("models/#{singular_class}.png", :height => 15, :border => 0, :label => mylabel )
    return link_to( 
      img + %( <font class="#{singular_class}">#{ mylabel}</font> ),
      obj,
      :label => mylabel 
    )
  end
  
  
end # ApplicationHelper


  ##################################################################################################################
  ###### ActiveRecord!!! ######
  ##################################################################################################################

class ActiveRecord::Base
   #include ColorsHelper
   @@description = "Description not set for '#{self}'. Please define '@@description' variable in the model itself!"
  
  def to_html
    to_html(self) rescue "boh123"
  end
  
  def to_s
    "<span class='error'>TBD.ToS(#{self.class}//#{self.id})</span>" rescue "ToS: FINISCIMI SCEMO! (#{$!})"
  end
  
  def self.names
    find(:all).map{|obj| obj.name }
  end

  def self.ids
    find(:all).map{|obj| obj.id }
  end
  
    # i.e.  v = Venue.find_or_create_by_name('Jakarta').save2
    # da un errore a importare i colori, CAZZO
  def save_ric
    include ColorsHelper rescue nil
    puts(yellow( "Trying to save ActiveRecord: ''#{self}'' (#{self.class})..."))
    ret = self.save
    unless ret
      puts("Something went wrong with saving of: ''#{self}''")
      puts(red(self.errors))
      #puts(red(self.error_messages))
      self.errors.each{|x,y|
        puts(" - #{red x.to_s} #{y}")
      }
    end
    return ret
  end
  def save2
    save_ric 
  end
    # non va con la classe anche se non richiede istanza, chiedo venia..
  def dot_key_values(hash)
    hash.map{|k,v| 
      "#{k}=\"#{ v.to_s.gsub(/"/, "''" ).gsub("\n",' ') }\"" 
    }.join(', ') rescue "boh1235: #{$!}"
  end
  
  def self.valida_tutti
    begin
     puts "Creato da Ric, costoso NON mettere nel codice usa solo da CLI!"
     find(:all).each{|obj|
      puts "Examining obj #{obj.id}: '#{obj.to_s}'.."
      if  obj.valid?
        puts "OK"
      else
        puts "id=#{obj.id} valid?=#{obj.valid?}"
        puts "Reasons: #{obj.errors.full_messages}"
      end 
     }
     true
    rescue
     false
    end
  end
  
  def self.description
    return @@description rescue "Description not set apparently for class '#{self.class}': #{$!}"
  end
  
  def starred_column(r)
    if r.starred
      image_tag( "icons/stars/star_on.png",  :height => 20)
    else
      image_tag( "icons/stars/star_off.png", :height => 20)
    end
  end
  
  def to_verbose_s
    ["<pre><u>#{self.class}.#{self.id}</u>: <b>'#{self.to_s}'</b>",
      (self.attributes.inspect.gsub(", ", ",\n ") rescue "Some Error with VerboseString: #{$!}" ),
      "<pre>"].join("\n")
  end
  
  def self.my_methods
    self.methods(false) # dovrebbe andar bene uguale!
  end

end # ActiveRecord::Base
##################################################################################################################
########################## ActiveRecord!!!                                            ############################
##################################################################################################################

