class AddUrlToCalendar < ActiveRecord::Migration
  def self.up
    add_column :calendars, :url, :string
    add_column :calendars, :external, :boolean
    add_column :events, :calendar_id, :integer
  end

  def self.down
    remove_column :events, :calendar_id
    remove_column :calendars, :external
    remove_column :calendars, :url
  end
end
