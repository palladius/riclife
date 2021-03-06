class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :code, :limit => 2
      t.string :name
      t.string :description
      t.boolean :favourite, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
