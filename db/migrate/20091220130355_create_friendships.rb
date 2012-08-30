class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.integer :person_id
      t.integer :followed_id
      t.string :notes
      t.integer :importance, :default => 30 # facciamo 10 (molto) 20 30 40 50 (poco)
      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
