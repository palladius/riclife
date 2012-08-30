class CreateRicEvents < ActiveRecord::Migration
  def self.up
    create_table :ric_events do |t|
        # fatti dal modello: 
        #  script/generate event_calendar --use-all-day ric_event event_view
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :all_day
        # BEGIN aggiunto da Ric
      t.text   :description
      t.string :icon_path
      t.boolean :private , :default => false
      t.string  :url
      t.integer :person_id   # creator
      t.integer :venue_id
      t.integer :event_type_id
      t.integer :calendar_id
        # END /aggiunto da Ric
      t.timestamps
    end
  end

  def self.down
    drop_table :ric_events
  end
end
