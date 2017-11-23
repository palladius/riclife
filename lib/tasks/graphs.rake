
#require '~/lib/ric.rb'
def yellow(s)
  "\033[0;34m#{s}\033[0m"
end
def pyellow(s)
  print yellow(s)
end

$graph_dir        = RAILS_ROOT + "/out/"
$central_person   = ENV["CENTRAL_PERSON_ID"] || 1       # riccardo :)

namespace :graph do
  
  task :friends => :environment do
    pyellow "TBD Send email to user <USER_ID> with closest pubs and events where he/she is :)"
  end
  
  task :people do
    central_person_nickname = 'primus_inter_pares'
    ret = <<-INTRO
      graph amicidublino {
    	  node [ shape=box, color=green, fontname="Sans", fontsize=10 ]
    	  edge [ color=blue, arrowhead=open, weight=5 ]
    	  
    	  #{central_person_nickname} [label="Primus Inter Pares", shape=box, color=blue, 
    	    image="src/riccardo.png" , 
    	    URL="http://www.palladius.it/" ];
    INTRO
    
    `mkdir #{$graph_dir}`
    Person.all.each {|p| 
      ret += " #{central_person_nickname} -- #{p.nickname} ; \n"
      ret += " #{p.nickname}  [label="#{p.name}", shape=box, color=black, image="#{HOME}/svn/carlesso/images/persone/#{p.photo_name}" ]; \n"
    }
    ppink ret
  end
  
  
  task :help do
    pyellow <<-HELP
      Ric, prova i seguenti taskz:"
        friends: Creates a .dot graph of all your friends TBD
        people:  Create a .dot/.svg/.png graph of all the people in the DB, linked to person #1 (to start) 
    HELP
  end
  
end