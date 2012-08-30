class CreateSportActivities < ActiveRecord::Migration
  def self.up
    create_table :sport_activities do |t|
      t.string  :name
      t.text    :description
      t.integer :duration,   :default => 60
      t.integer :person_id,  :default => 1
      t.integer :calories
      t.string  :activity
      t.date    :date,       :default => Time.now

      t.timestamps
    end
  end

  def self.down
    drop_table :sport_activities
  end
end
