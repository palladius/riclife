class ChangeEvClassTypeOnEvents < ActiveRecord::Migration
  def self.up
    rename_column :events,  :ev_class, :url
  end

  def self.down
    rename_column :events, :url,  :ev_class
  end

end
