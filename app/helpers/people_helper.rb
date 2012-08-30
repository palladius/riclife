module PeopleHelper
  include TagsHelper
  include LoansHelper
  
  THUMBS_SIZE = 25

  def starred_column(r)
    if r.starred
      image_tag( "icons/stars/star_on.png",  :height => 20)
    else
      image_tag( "icons/stars/star_off.png", :height => 20)
    end
  end
  
  def star_icon(onoff)
    image_tag( "icons/stars/star_#{ onoff ? 'on' : 'off' }.png", :height => 20) rescue "star_icon Exception: #{$!}"
  end

  def published_column(r)
    star_icon(r.published) 
  end
  
    # 1..5 stelle
  def relevance_column(r)
    ret = ''
    rel = r.relevance.to_i rescue 0
    ret += "#{rel}% "
    nstars = rel / 20 # 0..5
    nstars = 0 if nstars <= 0
    nstars = 5 if nstars >= 5
    (1..5).each {|i|
      ret += star_icon( i <=  nstars ) ##  if 3: STAR STAR STAR star star
    }
    ret
  end
  
  def mail_column(r)
    mail_to( r.mail , 
       image_tag("icons/internet-mail.png", :height => 20, :border => 0 ),
       :subject => "Ciao da RicLife" ) if r.mail rescue 'err mail'
  end

    # tracce di Web2.0 :)
    
  def goliardic_name_column(r)
    return 'not-goliard!' unless (r.goliard)
    img = image_tag("http://www.goliardia.it/immagini/persone/#{r.goliardic_name}.jpg", :height => 50, :align => :middle )
    lnk = link_to(r.goliardic_name.capitalize, "http://www.goliardia.it/utente.php?nomeutente=#{r.goliardic_name}") if r.goliardic_name rescue 'err gol'
    '<span class="goliard">' +
      img + lnk +
    '</span>'
  end
  
  def birthdate_column(r)
    bday = r.birthday rescue "Birth Date not given maybe?"
    (bday rescue 2) #+
#     " (#{distance_of_time_in_words_to_now(bday) rescue 1})" rescue "DateException: #{$!}"
  end
  
  def gender_column(r)
    image_tag(  "icons/#{r.male ? :mars : :venus }.png"  , :height => 30  )
  end

  def sexclass(male)
    return 'male'   if male == true
    return 'female' if male == false
    return 'unknownsex'
  end
  
  def fancy_name_column(r)
    icon_size = 7
    # font-weight: bold
    # font-style:italic;
    # font-style:oblique;
    style = '' # incrementale in base al genere
    modify_link = link_to(  icon('icons/edit', :height => icon_size ) , {:controller => :people, :action => "edit", :id => r.id }, :method => :get)    
    ret = link_to( r.to_html( :abbreviated => true ), r )
    ret += modify_link
    #ret += ' (*)' if r.starred
    ret +=  icon('icons/stars/yellow', :height => icon_size ) if r.starred
    style +=  "font-weight: bold; " if r.starred
    style +=  "color: gray; font-style:oblique; " if r.virtual
    ret +=  icon('icons/feluca', :height => icon_size ) if r.goliard # TBD link
    
    return "<span class='person' style='#{style}' label='LabelTest #{r.name_surname rescue :boh}' >#{ret}</span>"
  end
  
  # definito in AS::PeopleHelper e NON SO PERCHE e chiamato qui...
  # mi sa che helper son veramente delle CAZZO di librerie...
  # def name_surname_column(r)
  #     link_to( "<font class='#{sexclass(r.male)}'><b>#{r.name_surname}</b></font>", r ) rescue "err N_S(#{$!})"
  # #    "<font class='#{sexclass(r.male)}'><b>#{r.name_surname}</b></font>" rescue 'err N_S'
  # end

  def identities_column(r)
    #return 'IDENITY TBD'
    link_to("+", "/identities/new?record[person][id]=#{r.id}", :target => '_blank' ) + ' ' + # add new Identity for this user
      ( r.identities.map {|x| url_column(x)}.join ' ') rescue 'err identity' # existing
  end
  
  def work_venue_column(r)
    "<b class='venue'>#{r.work_venue || 'nil' }</b>" rescue 'Some error with WorkVenue'
  end
  
  def nationality_column(r)
    r.nationality
  end
  
  def country_column(r)
    link_to(r.country,r.country) rescue "NoCountryErr: #{$!}"
  end
  
  def venue_column(r)
    "<span class='venue'>#{r.venue }</span>" rescue 'Some error with WorkVenue'
  end
  
  #alias :work_venue_column :work_venues_column
  def him(person) ; person.male ? 'him' : 'her' ; end
	def his(person) ; person.male ? :his : :her ; end
	def His(person) ; person.male ? :His : :Her ; end  
end
