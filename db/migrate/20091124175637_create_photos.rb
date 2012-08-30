class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :photo_type_id
      t.integer :parent_id
      t.integer :size
      t.integer :width
      t.integer :height
      t.string :content_type
      t.string :filename
      t.string :thumbnail
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
