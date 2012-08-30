class AddFieldToApp < ActiveRecord::Migration
  def self.up
    add_column :apps, :username, :string
    add_column :inetorgpeople, :nickname, :string
    add_column :inetorgpeople, :goliard_name, :string
    change_column   :loans, :currency, :string, :default => 'euro'
    add_column :loans, :inetorgperson_id, :integer
  end

  def self.down
   # remove_column :loans, :inetorgperson_id
    change_column   :loans, :currency, :string, :default => nil
    remove_column :inetorgpeople, :nickname
    remove_column :inetorgpeople, :goliard_name
    remove_column :apps, :username
  end
end
