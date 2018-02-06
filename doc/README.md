Riclife
-------

[![Build Status](https://travis-ci.org/palladius/riclife.svg?branch=master)](https://travis-ci.org/palladius/riclife)
[![Code Climate](https://codeclimate.com/github/palladius/riclife.png)](https://codeclimate.com/github/palladius/riclife)

Welcome to Riclife.
Use this README file to introduce your application and point to useful places in the API for learning more.


INSTALL
-------
 
Metti qui come installare il mio cazzillo.

TODO per numero

figata: metti a posto i role requirements sicche ADMIN sia rcarlesso e gli altri USER
- http://code.google.com/p/rolerequirement/

1 rimetti 2.3.5 in environment.rb e magari anche l observer che hai tolto...
2 import persone da LDIF (magari con un check di validita su NOME+COGNOME o COGNOME+NOME e cosi via) e implementa warning
3 DEBITI metti anche il concetto di mensile bimestrale magari in seconda tabella con trigger che generi da uno N istanze di debito...
3 cancan come modulo di autenticazione..
9 Copia da railtickets il concetto di Data plugin figata (guarda due date in services!)
8	figata: http://conceptspace.wikidot.com/blog:19
5 Installa StreamLined per scaffolding.. morto, quindi installo activescaffolding..
7 prova Calendario fichissimo: http://github.com/elevation/event_calendar
8 AMDIN PANNELLO http://icebergist.com/posts/restful-admin-namespaced-controller-using-scaffolding
9 CHAT BOT che fai le search e le ADD da chat!
9 CACHE per i grafici: 
	- expire_page :controller =>"/articles", :action =>"index"

script/generate model loan title:string description:text quantity:float currency:string user_from_id:integer user_to_id:integer

Autenticazione gmail
--------------------

Puoi fare login con gmail E fare import dei contatti.
Magari puoi mettere username = email senza gmail.com e creare utente al primo login...
che dici?

	http://rorblog.techcfl.com/2008/04/18/import-gmail-contacts-using-ruby-on-rails

Sembra una puttanata da qui (crea ilk GmailAuthController che faccia sto cazzillo.. ):

	http://www.theirishpenguin.com/2008/06/25/a-little-help-on-importing-gmail-contacts-using-ruby-on-rails/

Video e Musica
--------------

Sistema di video e canzoni A TAG, che ci posso mettere DIAVOLO e trovo sia il film
indiavolato, il diavolo veste prada e sympathy for the devil :)
magari tanto ajax e importazioni automatiche da mp3.

- Addressbook che è padre di tante foglie (addresses o persons?)
magari faccio person e lo metto come java bean con metodi tipo SYNCABLE :)

$ script/generate controller Site index docs rss

da hiveminder
-------------

	#ZPJC (A) crea URL magici che parsano info (last_updated, ..) e semplifica crea persona!!! (Due 2010-04-17) [riclife sabatodo]
	#328LC (A) Implementa il Journaling (whatever u do, it logs in the journal an html link with "LNK_Riccardo just created a LNK_event here". decidi se LNK e' dinamico (con tipo GRAFFE) o statico. io farei statico tipo {{event|11}} [riclife sabatodo]
	#YV7M (B) comments e rotto +bug [bug riclife]
	#YV75 guarda http://conceptspace.wikidot.com/blog:19 [riclife]
	#YV7G esporta venues come kmz [devel projects riclife]
	#YV7V riclife ora che c e il magic_create fa un task che importa tutto da TODO list [riclife]
	#YV85 facebook gemma2 ma piu semplice http://facebook-ruby.sourceforge.net/ [@hetzner cool craic devel projects rails riclife]
	#32TW4 implementa Facebook Comments per un blog [rails riclife sabatodo]
	#YV7P (D) importa note dalla mia lista spesa/note fichissima in modo automatico e parsa + e chicciole come se piovesse e le date pure [cool riclife]


RicLife
-------

TODO
----

	9 fai un Ricfile upload che quando fai backuppa backuppa sia qui che con riclife-backuppa, che invece fa un bel ActiveReacord.create( :hostname => `hostname`, :user => `whoami`, :path => $1, :comments => $REST )

Figata:
	 results = Geocoding::get("George Docks, IFSC, Dublin")

capistrano ok, tante modifiche 22ottobre
capistrano ora funge da dio, immune a cambiamenti di DB :)

Cose da fare: 
	usa l'acts as synchable e vedi che viene fuori...
	L'ho messo in tmp/ per sicurezza, vedi se riesci a sincronizzare due Posts e se si... comincia a divertirti!

FEATURES
--------

Ora puoi chiamare:

  rake send_mailing MAILING_ID=1 COMMENT="vattelapesca giallo blu"
    gem install icalendar

HISTORY
-------

Installed ActiveScaffolding:
 script/plugin install git://github.com/activescaffold/active_scaffold.git
#- mi sa che per le exception notifiers appena emsee:
#http://github.com/rails/exception_notification/

script/plugin install http://juixe.com/svn/acts_as_voteable
script/generate scaffold --svn sport_activity name:string description:text duration:integer calories:integer activity:string date:date
script/plugin install exception_notification

DOC: http://rails.brentsowers.com/2008/01/exceptionnotification-plugin-for.html


TODO
----

Autocompletion:
  http://codeintensity.blogspot.com/2008/02/auto-complete-text-fields-in-rails-2.html
RDocs?!?

Thanks
------

My friends, for being so totally awesome.
