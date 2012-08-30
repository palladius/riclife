class CreateInetorgpeople < ActiveRecord::Migration
  def self.up
    create_table :inetorgpeople do |t|
      t.string :name
      t.string :surname
      t.string :mobile
      t.string :l
      t.string :o

      t.timestamps
    end
  end

  def self.down
    drop_table :inetorgpeople
  end
end
