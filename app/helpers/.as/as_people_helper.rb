	#module As::PeopleHelper
module As::AsPeopleHelper

  THUMBS_SIZE = 25

  def starred_column(r)
    if r.starred
      image_tag( "icons/stars/star_on.png",  :height => 20)
    else
      image_tag( "icons/stars/star_off.png", :height => 20)
    end
  end


  def published_column(r)
    image_tag( "icons/stars/star_#{ r.published ? 'on' : 'off' }.png", :height => 20) rescue 'err publis'
  end

  def mail_column(r)
    mail_to( r.mail , 
       image_tag("icons/internet-mail.png", :height => 20, :border => 0 ),
       :subject => "Ciao da RicLife" ) if r.mail rescue 'err mail'
  end

  def goliard_name_column(r)
    link_to(r.goliard_name, "http://www.goliardia.it/utente.php?nomeutente=#{r.goliard_name}") if r.goliard_name rescue 'err gol'
    # tracce di Web2.0 :)
  end
  
  def name_surname_column(r)
    link_to( "<font class='#{sexclass(r.male)}'><b>#{r.name_surname}</b></font>", r ) rescue "err N_S(#{$!})"
#    "<font class='#{sexclass(r.male)}'><b>#{r.name_surname}</b></font>" rescue 'err N_S'
  end

  def sexclass(male)
    return 'male'   if male == true
    return 'female' if male == false
    return 'unknownsex'
  end

  def identities_column(r)
    #return 'IDENITY TBD'
    link_to("+", "/identities/new?record[person][id]=#{r.id}", :target => '_blank' ) + ' ' + # add new Identity for this user
      ( r.identities.map {|x| url_column(x)}.join ' ') rescue 'err identity' # existing
  end
  
  def work_venue_column(r)
    "<b class='venue'>#{r.work_venue || 'nil' }</b>" rescue 'Some error with WorkVenue'
  end
  
  def venue_column(r)
    "<span class='venue'>#{r.venue }</span>" rescue 'Some error with WorkVenue'
  end
  #alias :work_venue_column :work_venues_column
  
end
