module CalendarsHelper

  def calendar_style(str)
    str.bold.tag('span', :class => 'calendar')
  end

  def name_column(r)
    color_table(
      r.color,
      calendar_style( r.to_label )
      ) # + "<font color='#{r.color}'>color test</font>"
  end
  def abbrev_column(r)
    calendar_style(r.abbrev.upcase) #.bold.tag('span', :class => 'calendar')
  end

  def external_column(r)
    yesno( r.external)
  end
  def private_column(r)
    yesno( r.private )
  end
  
  def size_column(r)
    (r.size.to_s.bold)
  end
  def url_column(r)
    link_to( 'Link',r.url, :target => '_blank' )  if r.url
  end

    def comments_column(r)
      "#{r.comments.size rescue -1 } commenti, mi pare"
    end
    
end
