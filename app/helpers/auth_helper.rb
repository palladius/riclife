
=begin

      ATTENTO RIC QUESTO HELPER è inutile!!!!
      c'è quel che ti serve in lib/authwenticated_system.rb !!!
      
      Anzi no, non è inutile, chiedo venia... mi sa che i controller usano uno, e le view usano l'altro.
      CASINO!!!
      Guarda cosa fa Ryan Bates nella bellissima EAGLE e cancell al'altra metà!!!
      
=end

module AuthHelper

  USER_ANONYMOUS = "riclife" # TBD anonymous
		# TBD '_anonymous' // 'anonymous42'

  def admin?
    get_user =~ /^(riccardo|fabio|rcarlesso|fmattei)$/
  end

  def anonymous?
    #    get_username == USER_ANONYMOUS  # obsoleto
    current_user.to_s.length == 0 # fatto da me fa cacare lo so...
  end
  
    # in futuro cambierà da modello a modello.. ad esempio magari tutti possono mettere una sport activity (?!?)
  def can_write?(model)
    ! (anonymous? )
#    return true if admin?
  end

  def group
    'ciofeca' if anonymous?
    admin? ? 'admin' : 'user'
  end

      #  request.env["REMOTE_USER"] || locale...
  def get_username()
    begin
      if request.env["REMOTE_USER"] # htpasswd
        return request.env["REMOTE_USER"]
      else
        if local_request?
          return nil ; #'lucilla'
        end
      end
    rescue USER_ANONYMOUS
    end
    return USER_ANONYMOUS
  end

  def get_user
    return current_user if current_user # login
    return User.find_by_login(get_username) if User.find_by_login(get_username) # apache
    #   current_user ||
    return User.find_by_login(USER_ANONYMOUS) if User.find_by_login(USER_ANONYMOUS) # last # e' qui che vien fuori fmattei TBD cambiami!!
    throw "Couldnt find a Apache user, a match over ANONYMOUS nor CurrentUser... you have to give me a hand y'know?!?"
  end
  
    # dal mio modello: person
    # TBD metti un ID da user a person_id
  def get_person()
    get_user.person ||
      Person.find_by_nickname(get_username)
  end
  
  alias :get_current_person :get_person

end
