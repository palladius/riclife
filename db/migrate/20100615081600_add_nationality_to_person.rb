class AddNationalityToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :nationality, :string,  :default => 'italian'
    add_column :people, :country_id,  :integer, :default => 106 # Italy, 104 Ireland
  end

  def self.down
    remove_column :people, :country_id
    remove_column :people, :nationality
  end
  
end

=begin
  NELLA MIGRATION NONN VA: mettiola a manhaus...
  
  puts "And now, making some countries more interesting than others :P"
    %w{ 
        Austria Belgium Brazil
        Canada Chile China
        Denmark France Germany 
        India Italy Ireland Japan
        Netherlands
        Portugal Spain 
        Switzerland Tunisia Turkey
        United_Kingdom United_States      
    }.each{ |country_name|
      c = Country.find_by_name(country_name.gsub(/_/,' ') )
      c.favourite = true
      puts("Favouring #{country_name}... " + (c.save! ? :ok : :ERR).to_s )
    }

=end