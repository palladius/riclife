class CreateEventAttendees < ActiveRecord::Migration
  def self.up
    create_table :event_attendees do |t|
      t.integer :event_id
      t.integer :person_id
      t.boolean :confirmed, :default => false
      t.boolean :busy,      :default => true # person appears as busy during that time
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :event_attendees
  end
end
