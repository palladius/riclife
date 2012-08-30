class AddLoginToIdentities < ActiveRecord::Migration
  def self.up
    add_column :identities, :login, :string
  end

  def self.down
    remove_column :identities, :login
  end
end
