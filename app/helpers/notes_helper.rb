module NotesHelper
  
  def completed_column(r)
    boolean_icon r.completed
  end
  
  def relevance_icon(relevance, hide_when_ok = true )
    return icon('tasks/red')   if relevance <= 10
    return icon('tasks/yellow') if relevance <= 20
    return hide_when_ok ? 
      '' :
      icon('tasks/green')     
  end
  
  def deadline_column(r)
    str = r.deadline.to_s
    return str.tag('font', :color =>  'red').bold            if r.overdue?   #BUG non va sta funzione!
    return ( str + " (near baco)" ).tag('font', :color =>  'purple')  if r.near_to_overdue?
    str.tag('font', :color => 'green')
  end
  
  def progress_column(r)
    r.progress > 0 ? "#{r.progress} %" : ''
  end
  
  def relevance_column(r)
    #r.relevance  + 
    relevance_icon(r.relevance) rescue "Err: #{$!}"
  end
  
    # TBD porta in CSS e metti i 3 valori di rilevanza in MODEL!
  def stylish_title(r)
    str = relevance_column(r) + r.to_s
    #str += " (overdue!)"  if r.overdue?
    return str.tag("font", :color => 'gray' ).italic     if r.completed || (! r.active)
    return str.tag("font", :color => 'red' ).bold        if r.relevance <= 10 
    return str.tag("font", :color => 'PaleGoldenRod' ).bold      if r.relevance <= 20 
    str
  end
  
  def title_column(r)
    stylish_title(r) rescue "Stylish Title err: #{$!}"
  end
  
  
end
