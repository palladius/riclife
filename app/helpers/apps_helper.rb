module AppsHelper

  def icon_column(r)
    #image_tag "apps/#{r.icon || "unknown_icon.png" }", :size => '15x15'
    icon_magic(r,'icon',15)
  end

  def app_url_column(r)
    link_to 'Sito (attento doppione)', r.url
  end

  def name_column(r)
    link_to "<b>#{r.name.capitalize}</b>", r
  end

  #def icon_column(r)
  #  ApplicationHelper::icon_magic(r)
  #end
  
end
