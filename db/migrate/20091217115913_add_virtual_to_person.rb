class AddVirtualToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :virtual, :boolean, :default => false
  end

  def self.down
    remove_column :people, :virtual
  end
end
