class RenameUserIdToPersonIdToCalendar < ActiveRecord::Migration
  def self.up
     rename_column :calendars, :user_id, :person_id
  end

  def self.down
    rename_column :calendars, :person_id, :user_id
  end
end
