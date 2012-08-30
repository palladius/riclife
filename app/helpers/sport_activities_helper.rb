module SportActivitiesHelper
  
  def activity_column(r)
    image_tag("sport_activities/#{r.activity}.png", :height => 20 )  if r.activity
  end
  def name_column(r)
    (r.name || '-').bold
  end
  def duration_column(r)
    myduration = r.duration || 0
    hours   = myduration / 60
    minutes = myduration % 60
    ret = (hours > 0)  ? "#{hours}<sup>h</sup> " : '' 
    ret += "#{minutes}'" unless minutes == 0
    ret += ' (!!!)' if hours >= 2
    ret
  end
  
end
