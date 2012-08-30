class RenameClassInEvents < ActiveRecord::Migration
  def self.up
		rename_column :events, :class, :ev_class
  end

  def self.down
		rename_column :events, :ev_class, :class
  end
end
