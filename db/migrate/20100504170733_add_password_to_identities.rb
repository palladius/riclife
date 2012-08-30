class AddPasswordToIdentities < ActiveRecord::Migration
  def self.up
    add_column :identities, :password, :string
  end

  def self.down
    remove_column :identities, :password
  end
end
