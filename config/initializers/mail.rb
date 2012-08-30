#ActionMailer::Base.delivery_method = :smtp

#ActionMailer::Base.smtp_settings = {
#    :address => "mail.palladius.eu",
#    :port => 25,
#    :domain => "www.palladius.eu",
#    :authentication => :login,
#    :user_name => "riclife@palladius.eu",
#    :password => "pazzword_secret"
#}

ActionMailer::Base.delivery_method = :sendmail
