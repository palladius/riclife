class AddDescriptionToRicfile < ActiveRecord::Migration
  def self.up
    add_column :ricfiles, :description, :text
  end

  def self.down
    remove_column :ricfiles, :description
  end
end
