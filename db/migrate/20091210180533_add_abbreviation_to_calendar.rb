class AddAbbreviationToCalendar < ActiveRecord::Migration
  def self.up
    add_column :calendars, :abbrev, :string
    add_column :calendars, :icon_path, :string
  end

  def self.down
    remove_column :calendars, :icon_path
    remove_column :calendars, :abbrev
  end
  
end
