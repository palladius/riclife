#!/usr/bin/env ruby

require 'rubygems'
require 'gruff'

g = Gruff::Line.new
g.title = "I Valori di D&D dei miei amici " 

# g.data("Apples", [1, 2, 3, 4, 4, 3])

Person.find(:all).interesting.map{|u| 
  g.data( u.to_s, u.dnd_attributes) 
}

#g.labels = {0 => '2003', 2 => '2004', 4 => '2005'}
g.labels = Person.dnd_labels

# { 
#   0 => 'Str', 
#   1 => 'Int' 
#   2 => 'Wis', 
#   3 => 'Dex' 
#   4 => 'Con', 
#   5 => 'Cha' 
#   }

#g.write('my_fruity_graph.png')
g.write('riccardo_amici_dnd.png')
