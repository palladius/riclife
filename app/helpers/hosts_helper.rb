module HostsHelper

  def os_column(r)
    #TBD image_tag("host_oss/#{r.os}.png")
    (r.os|| '-' ).capitalize
  end

  def ip_column(r)
    ip = r.ip || '127.0.0.1'
    link_to (r.ip || '' ), "ssh://#{ip}"
  end

end
