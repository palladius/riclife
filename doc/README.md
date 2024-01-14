Riclife
-------

Note: I have two versions of it, and I'm currently trying to understand which works: `riclife` on github / `riclife2020` on gprojects.

[![Build Status](https://travis-ci.org/palladius/riclife.svg?branch=master)](https://travis-ci.org/palladius/riclife)
[![Code Climate](https://codeclimate.com/github/palladius/riclife.png)](https://codeclimate.com/github/palladius/riclife)

Welcome to Riclife.
Use this README file to introduce your application and point to useful places in the API for learning more.

Versions:

* ruby:  '1.8.7' (rbenv install 1.8.7)
* rails: '2.3.18'

INSTALL
-------

Metti qui come installare il mio cazzillo.

    1. cp .env.dist .env
    2. Tweak `.env` and save it somewhere

figata: metti a posto i role requirements sicche ADMIN sia rcarlesso e gli altri USER

    http://code.google.com/p/rolerequirement/

1 rimetti 2.3.5 in environment.rb e magari anche l observer che hai tolto...
2 import persone da LDIF (magari con un check di validita su NOME+COGNOME o COGNOME+NOME e cosi via) e implementa warning
3 DEBITI metti anche il concetto di mensile bimestrale magari in seconda tabella con trigger che generi da uno N istanze di debito...
3 cancan come modulo di autenticazione..
9 Copia da railtickets il concetto di Data plugin figata (guarda due date in services!)
8	figata: http://conceptspace.wikidot.com/blog:19
7 prova Calendario fichissimo: http://github.com/elevation/event_calendar
8 ADMIN PANNELLO http://icebergist.com/posts/restful-admin-namespaced-controller-using-scaffolding
9 CHAT BOT che fai le search e le ADD da chat!
9 CACHE per i grafici:
	- expire_page :controller =>"/articles", :action =>"index"

script/generate model loan title:string description:text quantity:float currency:string user_from_id:integer user_to_id:integer

GMail auth
----------

You can do GMail login and import contacts (!)
Magari puoi mettere username = email senza gmail.com e creare utente al primo login...
che dici?

	http://rorblog.techcfl.com/2008/04/18/import-gmail-contacts-using-ruby-on-rails

Sembra una puttanata da qui (crea ilk GmailAuthController che faccia sto cazzillo.. ):

	http://www.theirishpenguin.com/2008/06/25/a-little-help-on-importing-gmail-contacts-using-ruby-on-rails/

Video & Music
-------------

Sistema di video e canzoni A TAG, che ci posso mettere DIAVOLO e trovo sia il film
indiavolato, il diavolo veste prada e sympathy for the devil :)
magari tanto ajax e importazioni automatiche da mp3.

- Addressbook che è padre di tante foglie (addresses o persons?)
magari faccio person e lo metto come java bean con metodi tipo SYNCABLE :)

$ script/generate controller Site index docs rss

TODOs
-----

Riccardo TODOs: see `TODO` files

FEATURES
--------

Ora puoi chiamare:

  rake send_mailing MAILING_ID=1 COMMENT="vattelapesca giallo blu"
    gem install icalendar

Figata:

	 results = Geocoding::get("George Docks, IFSC, Dublin")

capistrano ok, tante modifiche 22ottobre
capistrano ora funge da dio, immune a cambiamenti di DB :)

HISTORY
-------

Installed ActiveScaffolding:

    script/plugin install git://github.com/activescaffold/active_scaffold.git

Mi sa che per le exception notifiers appena messe:

    http://github.com/rails/exception_notification/

    script/plugin install http://juixe.com/svn/acts_as_voteable
    script/generate scaffold --svn sport_activity name:string description:text duration:integer calories:integer activity:string date:date
    script/plugin install exception_notification

DOC: http://rails.brentsowers.com/2008/01/exceptionnotification-plugin-for.html


Thanks
------

My friends, for being so totally awesome.
