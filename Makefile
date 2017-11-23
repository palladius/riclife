#################################
# Upgrade efforts: see `UPGRADE`


info:
	bundle platform --ruby

prep:
	gem install -v=2.3.18 rails
#	gem install -v=2.3.12 rails
	@echo remember to create your own 'config/smtp_gmail.yml' with your gmail and password.

bundle:
	bundle install

run: bundle
	script/server

run-dev:
	rake db:setup 
	script/server

tests:
	@grep -q user_name config/smtp_gmail.yml || echo "T1. Please create config/smtp_gmail.yml"
	echo .tables | sqlite3 db/development.sqlite3