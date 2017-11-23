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
	script/server -e development -p 3000
