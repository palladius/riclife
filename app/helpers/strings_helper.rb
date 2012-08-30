module StringsHelper

  def foo
    'bar'
  end
  
end



  ###################################
  # redefine string stuff... va messo fuori dal modulo se no col cacchio che ridefinisce string...
class String

  def tag(tagname, options={} )
    opt_str=options.map{|k,v| "#{k}='#{v}'" }.join(' ')
    "<#{tagname} #{opt_str}>#{self}</#{tagname}>\n"
  end
  def pre()
    tag('pre')
  end
  
  def span(options={})
    tag('span', options)
  end

  def bold
    tag('b')
  end
  def italic
    tag('i')
  end
  def underline
    tag('i')
  end
  def quote
    "‘#{self}’"
  end
  def nicknamize
    gsub(' ','_').downcase
  end
  alias :nicknameize :nicknamize # toglimi!

  # TBD put in color helper
  def yellow()
    "\033[1;33m[YELLOW] #{self}\033[0m"
  end

  alias :green :yellow

end # String
