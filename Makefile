#################################
# Upgrade efforts: see `UPGRADE`


info:
	bundle platform --ruby

prep:
	gem install -v=2.3.18 rails
#	gem install -v=2.3.12 rails

bundle:
	bundle install

run: bundle
	script/server
