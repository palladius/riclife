class CreateRiclocations < ActiveRecord::Migration
  def self.up
    create_table :riclocations do |t|
      t.string :name
      t.text :description
      t.string :x
      t.string :y
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :riclocations
  end
end
