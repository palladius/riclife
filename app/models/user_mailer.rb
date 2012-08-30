class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'

    # as suggested by: http://avnetlabs.com/rails/restful-authentication-with-rails-2
#    @body[:url]  = "http://YOURSITE/activate/#{user.activation_code}"
    @body[:url]  = "http://#{SITE_URL}/activate/#{user.activation_code}"


  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    #@body[:url]  = "http://YOURSITE/"
    @body[:url]  = "http://#{SITE_URL}/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "palladiusbonton@gmail.com"
      @subject     = "[WhatsTheCraic] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
