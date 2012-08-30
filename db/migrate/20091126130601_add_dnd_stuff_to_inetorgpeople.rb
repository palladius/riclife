class AddDndStuffToInetorgpeople < ActiveRecord::Migration
  def self.up
    add_column :inetorgpeople, :strength, :integer,   :default => 10
    add_column :inetorgpeople, :dexterity, :integer,   :default => 10
    add_column :inetorgpeople, :wisdom, :integer,   :default => 10
    add_column :inetorgpeople, :intelligence, :integer,   :default => 10
    add_column :inetorgpeople, :constitution, :integer,   :default => 10
    add_column :inetorgpeople, :charisma, :integer,   :default => 10
  end

  def self.down
    remove_column :inetorgpeople, :charisma
    remove_column :inetorgpeople, :constitution
    remove_column :inetorgpeople, :intelligence
    remove_column :inetorgpeople, :wisdom
    remove_column :inetorgpeople, :dexterity
    remove_column :inetorgpeople, :strength
  end
end
