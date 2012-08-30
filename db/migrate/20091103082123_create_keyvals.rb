class CreateKeyvals < ActiveRecord::Migration
  def self.up
    create_table :keyvals do |t|
      t.string :key
      t.string :val
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :keyvals
  end
end
