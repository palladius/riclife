# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

SITE_URL = "riclife.local"

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# presa dal coso di gmail:
# http://github.com/openrain/action_mailer_tls
config.action_mailer.raise_delivery_errors = true
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :smtp

# Don't care if the mailer can't send

#config.action_mailer.raise_delivery_errors = true
#config.action_mailer.raise_delivery_errors = true
#config.action_mailer.delivery_method = :sendmail
#config.action_mailer.smtp_settings = { :address => 'smtp.palladius.eu', :domain => Socket.gethostname }

# if ($usa_exception_notification)
#   ExceptionNotifier.exception_recipients = %w( palladius@email.it palladiusbonton@gmail.com riccardo.carlesso@heanet.ie rcarlesso@yahoo.it )
#   ExceptionNotifier.email_prefix = "[RicLife-Prod] " # APPLICATION TBD
#   ExceptionNotifier.sender_address = %( "Riclife RAILS_ENV=#{RAILS_ENV} Exception Notifier" <palladiusbonton@gmail.com> ) 
# end
