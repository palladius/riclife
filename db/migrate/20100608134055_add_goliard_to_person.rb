class AddGoliardToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :goliard, :boolean , :default => false
    add_column :people, :goliardic_name, :string # , :default => 'deve coincidere con quello in www.goliardia.it!'
  end

  def self.down
    remove_column :people, :goliardic_name
    remove_column :people, :goliard
  end
end
