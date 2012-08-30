module IdentitiesHelper
  include ApplicationHelper
  #image_tag "apps/#{r.icon}", :size => '25x25'

  def local_path_column(r)
    "<tt><small>#{r.local_path || 'missing local path!'}</small></tt>"
  end


  def password_column(r)
    return '-' unless defined?(r.password)
    '*' * r.password.to_s.length rescue '***'
  end

  def uid_column(r)
    link_to("<b>#{r.uid}</b>", r.build_link, :target => '_blank' )
  end
  
    # array of [username, email]
  def imported_contacts_visualize(arr_contacts)
    $small_size = 3
    raise "Unknown Contacts structure (its not array): #{arr_contacts.class}" unless arr_contacts.is_a?(Array)
    if arr_contacts.size <  $small_size
      return "<b>Strange size for your contacts</b>: <pre>#{ arr_contacts.inspect }</pre>"
    end
    arr_contacts.map{ |user_mail|
      username = user_mail[0] || '???'
      email = user_mail[1] || "unknown_email"
      #{}"- #{username} -+- mailto:#{email}"
      link_to(username, "mailto:#{email}") + ' ' + link_to("(i)","/identities/import_contact?email=#{email}&&username=#{username}")
    }.join(" ;; ")
    return arr_contacts.inspect #.size
  end
end
