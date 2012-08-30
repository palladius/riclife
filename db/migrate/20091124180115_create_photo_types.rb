class CreatePhotoTypes < ActiveRecord::Migration
  def self.up
    create_table :photo_types do |t|
      t.string :name
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :photo_types
  end
end
