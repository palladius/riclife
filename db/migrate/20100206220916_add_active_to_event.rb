class AddActiveToEvent < ActiveRecord::Migration
  def self.up
    add_column :events,    :active, :boolean,  :default => true
    add_column :calendars, :active, :boolean,  :default => true
  end

  def self.down
    remove_column :calendars, :active
    remove_column :events,    :active
  end
end
