class CreateCalendars < ActiveRecord::Migration
  def self.up
    create_table :calendars do |t|
      t.string :name
      t.text :description
      t.boolean :private
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :calendars
  end
end
