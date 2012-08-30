class AddPublicToFriendships < ActiveRecord::Migration
  def self.up
    add_column :friendships, :visible, :boolean, :default => true
  end

  def self.down
    #remove_column :friendships, :public 
    remove_column :friendships, :visible
  end
end
