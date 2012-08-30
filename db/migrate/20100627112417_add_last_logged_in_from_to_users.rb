class AddLastLoggedInFromToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_login_place, :string
  end

  def self.down
    remove_column :users, :last_login_place
  end
end
