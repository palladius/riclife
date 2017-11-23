UPGRADE
=======

2017-11-05

Trying to get this to work on my Ubuntu 14.04... a mess :/

Upgrading from rails 2.3.5.. things needed.

1. Read: https://stackoverflow.com/questions/15349869/undefined-method-source-index-for-gemmodule-nomethoderror

says: 
	I just ran into this problem myself while trying to upgrade an older Rails app from REE 1.8.7 to 1.9.3-p385. Oddly, Ruby 1.9.3-p327 works just fine. What it came down to was ruby-1.9.3-p385 had installed RubyGems version 2.0.2 for me, and 1.9.3-p327 has RubyGems v1.8.23 installed.

   - Rails 2.3.5 needs to be updated to a minimum of 2.3.17
   - needs: ruby1.9.3-p327 or maybe not. Rails2.3 should work well only with ruby 1.8 and ruby1.9.1





# Missing openssl: https://stackoverflow.com/questions/14845481/cannot-load-such-file-openssl-loaderror

ruby version was wrong => had to uninstall ruby from my computer (also "ruby-bundle").
This fixed the ruby version conflict problem, now it only see sconfligct between Gemfile and .ruby-version so since it reads the first i killed the 2nd.

20171105-1931 Now I get openssl issue: 

Could not load OpenSSL.
You must recompile Ruby with OpenSSL support or change the sources in your Gemfile from 'https' to 'http'. Instructions for compiling with OpenSSL using RVM are available at http://rvm.io/packages/openssl.
LoadError: cannot load such file -- openssl


     $ rvm pkg install openssl

Waiting to get openssl installed on all Rubiez.


20171105-1932 iconv issue (again)

/home/riccardo/.rvm/rubies/ruby-2.2.6/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:121:in `require': cannot load such file -- iconv (LoadError)

20171105-1941: ho reinstallato la 1.9.3-p237 e sembra andare... eccetto che..


$ script/server 
/home/riccardo/.rvm/rubies/ruby-1.9.3-p327/lib/ruby/site_ruby/1.9.1/rubygems/core_ext/kernel_require.rb:55:in `require': iconv will be deprecated in the future, use String#encode instead.
=> Booting WEBrick
=> Rails 2.3.17 application starting on http://0.0.0.0:3000
/home/riccardo/.rvm/gems/ruby-1.9.3-p327/gems/rails-2.3.17/lib/rails/gem_dependency.rb:21:in `add_frozen_gem_path': undefined method `source_index' for Gem:Module (NoMethodError)
	from /home/riccardo/.rvm/gems/ruby-1.9.3-p327/gems/rails-2.3.17/lib/initializer.rb:298:in `add_gem_load_paths'
	from /home/riccardo/.rvm/gems/ruby-1.9.3-p327/gems/rails-2.3.17/lib/initializer.rb:132:in `process'
	from /home/riccardo/.rvm/gems/ruby-1.9.3-p327/gems/rails-2.3.17/lib/initializer.rb:113:in `run'


=> https://stackoverflow.com/questions/15349869/undefined-method-source-index-for-gemmodule-nomethoderror

a guys suggests to download the gems (wow!)

    $ rvm rubygems latest-1.8


$ rvm rubygems latest-1.8
ruby-1.9.3-p327 - #downloading rubygems-1.8.30
ruby-1.9.3-p327 - #extracting rubygems-1.8.30.....
ruby-1.9.3-p327 - #removing old rubygems.........
ruby-1.9.3-p327 - #installing rubygems-1.8.30..
riccardo@masagno:~/git/riclife$ script/server 
/home/riccardo/.rvm/rubies/ruby-1.9.3-p327/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require': iconv will be deprecated in the future, use String#encode instead.
=> Booting WEBrick
=> Rails 2.3.17 application starting on http://0.0.0.0:3000
NOTE: Gem.source_index is deprecated, use Specification. It will be removed on or after 2011-11-01.
Gem.source_index called from /home/riccardo/.rvm/gems/ruby-1.9.3-p327/gems/rails-2.3.17/lib/rails/gem_dependency.rb:21.
NOTE: Gem::SourceIndex#initialize is deprecated with no replacement. It will be removed on or after 2011-11-01.
Gem::SourceIndex#initialize called from /home/riccardo/.rvm/gems/ruby-1.9.3-p327/gems/rails-2.3.17/lib/rails/vendor_gem_source_index.rb:100.
NOTE: Gem.source_index is deprecated, use Specification. It will be removed on or after 2011-11-01.
Gem.source_index called from /home/riccardo/.rvm/gems/ruby-1.9.3-p327/gems/rails-2.3.17/lib/rails/gem_dependency.rb:78.


much better! Now it runs A LOT! Wai...

20171105-1945 doesnt find the gems

    $ gem install calendar_date_select contacts geoip geokit hpricot icalendar sqlite3 ym4r openrain-action_mailer_tls 
