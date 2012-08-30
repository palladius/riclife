class AddTimezoneToCalendar < ActiveRecord::Migration
  def self.up
    add_column :calendars, :timezone, :string, :default => 'Ireland/Dublin'
  end

  def self.down
    remove_column :calendars, :timezone
  end
end
