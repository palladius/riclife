class AddIconPathToProjectsAndNotes < ActiveRecord::Migration
  def self.up
    add_column :projects, :icon_path, :string
    add_column :notes,    :icon_path, :string
  end

  def self.down
    remove_column :projects, :icon_path
    remove_column :notes, :icon_path
  end
 
end
