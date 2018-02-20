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

run-prod: bundle
	./run-prod.sh

tests:
	@echo "T1. You added custom file: 'config/smtp_gmail.yml'"
	@grep -q user_name config/smtp_gmail.yml || echo "T1. Please create config/smtp_gmail.yml"
	@echo "T2. DB exists:"
	echo .tables | sqlite3 db/development.sqlite3
	@echo "T3. First user has a person and that has a project :)"
	# Fix: u=User.first ; u.person = Person.first
	# person gets created but somehow not attached to user as it should be.
	echo 'Project.by_person(User.first.person)' | script/console 
