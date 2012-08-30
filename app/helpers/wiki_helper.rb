module WikiHelper

  def smart_path(cls,id)
    "/#{cls.tableize}/#{id}"
  end
  
  def auto_iconed_name(mymodel,id)
    obj = mymodel.find(id) rescue err_str( "#{$!}")
    image_tag("models/#{obj.class.to_s.downcase}.png", :height => 12) + 
      ( %(<span class="#{obj.class.to_s.downcase}">#{obj.to_s.capitalize}</span>) rescue "Err: #{$!}") 
  end
  def transform_text_wiki_style(content)
    content = content.to_s
      content.gsub(/\{(Page|Person|User|Venue);(\d+)(;(.*))?\}/ ) { 
      cls = $1
      id  = $2
      description = $4 rescue "No description provided"
      case cls
        when 'User'
          name = auto_iconed_name(User,id)
        when 'Venue'
          name = auto_iconed_name(Venue,id)
        when 'Page'
          name = auto_iconed_name(Page,id) # .name rescue err_str( "Erore: #{$!}")
        when 'Person'
          name = auto_iconed_name(Person,id) 
        else
          name = "#{cls} ##{id}"
      end
      label = name
      label += " (#{description})" if description
      link_to(label, smart_path(cls,id) )
    }
  end
end
