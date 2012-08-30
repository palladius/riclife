class AddMainToCalendar < ActiveRecord::Migration
  def self.up
    add_column :calendars, :main, :boolean, :default => false
    add_column :projects, :main, :boolean, :default => false
  end

  def self.down
    remove_column :projects, :main
    remove_column :calendars, :main
  end
end
