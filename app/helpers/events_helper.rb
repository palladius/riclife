module EventsHelper

  def tstart_column(r)
    distance_of_time_in_words(Time.now, r.tstart, true )
  end

  def tend_column(r)
    distance_of_time_in_words(Time.now, r.tend, true )
  end

  def duration_column(r)
    distance_of_time_in_words(r.tstart, r.tend, true )
  end

  def summary_column(r)
    r.summary + ' ' +
			#link_to( '(ics)', "/events/#{r.id}.ics", :target => '_blank') +
			link_to( '(txt)', "/events/#{r.id}.txt", :target => '_blank')
  end

  def icon_column(r)
    icon_magic(r, 'icon' , '25')
  end

  def list_row_class(record)
    record.past? ? 'past' : 'future'
  end
  
  def event_type(r)
    link_to(r.event_type.to_s.capitalize, r.event_type , :style => 'event_type' )
  end

  def repeats_column(r)
    image_tag('icons/repeat.png', :height => 25) if r.repeats
  end
  
  def summary_column(r)
    "<span class='event summary'>#{r.summary}</span>"
  end
  def creator_column(r)
    link_to(r.creator,r.creator)
  end
  def venue_column(r)
    "<span class='venue'>" +
      link_to(r.venue, r.venue)  + 
    "</span>"
  end

  def snippet_column(r)
    #{}"<div align='right' >" + icon_path_column(r) + "</div>\n" +
      "<b>#{ link_to(summary_column(r),r) }</b> <BR/>\n" +
      "<i>(#{event_type(r)} by #{creator_column(r)})</i> <br/> " +
      " @ " +      venue_column(r)
      # tstart_column
    
  end
  
  def comment_column(r)
    link_to "Add comment", '/comments/comment_form'
  end
  
  def calendar_column(r)
   #link_to
   r.calendar.to_label rescue "Err for #{r}: ''#{$!}''" #.to_label # .bold
  end

end
