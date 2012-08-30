class CreateGugolCalendars < ActiveRecord::Migration
  def self.up
    create_table :gugol_calendars do |t|
      t.string :name
      t.string :calname,     :default => '_riclife'
      t.string :color,       :default =>  'blue'
      t.string :username,    :default => 'CHANGEME@gmail.com'
      t.string :password  
      t.text   :description
      t.integer  :person_id 
      t.timestamps
    end
  end

  def self.down
    drop_table :gugol_calendars
  end
end
