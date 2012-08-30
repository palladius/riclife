class AddProjectToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :project_id, :integer
  end

  def self.down
    remove_column :notes, :project_id
  end
end
