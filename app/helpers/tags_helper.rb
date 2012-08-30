module TagsHelper

  def sample_tags
    sminuzza_tags 'dublin bologna riccardo gnocca connector goliardia friend sex love gnocca family son spouse imelda_may' 
  end
  
  ### Use partial "tags/link" , :tags => ARRAY
  
  # restituisce un array... '
  def sminuzza_tags(str)
    return [] unless str
    str.split(/[ ,]/).map{|tag| '' + tag.downcase }.select{|tag| tag.length > 1 }.sort.uniq rescue ["Execption::SminuzzaTag", "#{$!}" ]
  end
  
  def render_tags(obj)
    render :partial => "tags/link",  :locals => { :tags => obj.tags }, :class => 'tag'
  end
  
    # i.e., Dublin, 14
  def render_tag(tag,cardinality)
    tagdebug = false
    size = (Math.log(cardinality) * 10).to_i # logarithimc o non se ne esce! :)
    fontsize = 50 + size * 2 # percentage: 100 = equal
    visualized_tag = tag.downcase.gsub('_',' ') # renders '_' as spaces...
    title = 'Tag ' + tag.downcase + " (CARD=#{cardinality}, size//fontsize=#{size}//#{fontsize})"
    visualized_tag += " (#{cardinality})" if tagdebug
    fontstyle = "font-size: #{fontsize}%;"
    link_to("<font class='tag' style='#{fontstyle}' title='#{title}' >#{visualized_tag}</font>", "/tags/#{tag}") 
  end

end
