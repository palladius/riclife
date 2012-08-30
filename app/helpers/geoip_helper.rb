module GeoipHelper
  require 'rubygems'
  require 'geoip'
  
  def whereis(ip)
    ip = '137.40.90.186' if (ip == '127.0.0.1')  # hetzner
    geo = GeoIP.new( File.expand_path("~/svn/carlessong/geoip/GeoLiteCity.dat"))  #{ }"#{RAILS_ROOT}/app/geoip/GeoLiteCity.dat" )
    #g = geo.city( 'google.com' ) # errore per IPv6... 74.125.43.103 is an IP
    g = geo.city( ip ) # errore per IPv6... 74.125.43.103 is an IP]
    #return g
    # g[0] #hostname
    # g[1] #ip
    # g[2] #countrycode
    # g[4] #country
    # g[7] #city
    # g[8] #postalcode
    # g[9] #latitude
    # g[10] #longitude
    return g
  end
  
  def google_maps(address)
    "http://maps.google.ie/maps?q=#{address}"
  end
  
  def geo_city_nation(ip)
    func_ver = '1.1b'
    g = whereis(ip) 
    city_country = (g[7] + ", " + g[4]) rescue "Exception(#{$!}), Antarctica"
    if (g.class == Array)
      v = Venue.find_or_create_by_name(city_country) { |v|
        v.lat = g[9]
        v.lng = g[10]
        v.tags = 'geoip, auto'
        v.description = "Automatcially created by geo_city_nation for ip: #{ip} probably by user #{current_user rescue :boh }. Country code: '#{ g[2] }'. FuncVer=#{func_ver}" + "\n\n#{g.join("\n")}"
        v.address = " #{city_country}"
          # auto google image :P
        v.icon_path = `~/bin/gugol-image -n '#{city_country}' | egrep ^http | head -1`.strip rescue "/images/pizza.png#Error automagical gugol image: #{$!}"
        # v.country = Country.find_or_create_by_name()
      }
      return link_to(v,v)
    end
    return link_to(city_country, google_maps(city_country), :target => '_new' )
  end
end