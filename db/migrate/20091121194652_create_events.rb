class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :summary
      t.text :description
      t.integer :venue_id
      t.string :location
      t.time :start
      t.time :end
      t.boolean :repeats
      t.integer :organizer_id
      t.string :class
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
