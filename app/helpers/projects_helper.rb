module ProjectsHelper
  
  def name_column(r)
    str = r.to_label # .capitalize
    str = "<b>#{str}</b>" if r.main
    "<span class='project'>#{str}</span>"
    #r.main ? "<b>str</b>" :  str
  end

end
