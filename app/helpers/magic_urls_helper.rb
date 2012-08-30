module MagicUrlsHelper

  def url_column(r)
    icon('url.png') + link_to( r.url, r.url)
  end
  
end
