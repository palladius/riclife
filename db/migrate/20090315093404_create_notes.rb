class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.string :title
      t.text :description
      t.boolean :active
      t.date :deadline

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
