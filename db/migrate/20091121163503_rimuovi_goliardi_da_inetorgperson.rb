class RimuoviGoliardiDaInetorgperson < ActiveRecord::Migration
  def self.up
    remove_column :inetorgpeople, :goliard_name
  end

  def self.down
    add_column :inetorgpeople, :goliard_name, :string
  end
end
