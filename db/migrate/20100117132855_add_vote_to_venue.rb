class AddVoteToVenue < ActiveRecord::Migration
  
#  $votable_models = [ :ric_events, :events, :people, :calendars, :notes ]
  $votable_models = %w{ calendars events notes people ric_events  }
  
  def self.up
    $votable_models.each{ |modello|
      puts "Adding 'vote' field to model: #{modello}"
      add_column modello, :vote, :integer, :default => 59 # appena meno della sufficienza
    }
  end

  def self.down
    $votable_models.reverse.each{ |modello|
      puts "DEB Removing 'vote' field from model: #{modello}"
      remove_column modello, :vote      
    }
  end
end
