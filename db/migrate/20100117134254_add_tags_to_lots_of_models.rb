class AddTagsToLotsOfModels < ActiveRecord::Migration
  
  $taggable_models = %w{ calendars events loans notes people ric_events }
  
  def self.up
    $taggable_models.each{ |modello|
      puts "Adding 'tags' field to model: #{modello}"
      add_column modello, :tags, :string
    }
  end

  def self.down
    $taggable_models.reverse.each{ |modello|
      remove_column modello, :tags      
    }
  end
  
end
