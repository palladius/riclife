class CreateRicfiles < ActiveRecord::Migration
  def self.up
    create_table :ricfiles do |t|
      t.string :host
      t.string :path
      t.string :URI
      t.string :tags
      t.text :metatags

      t.timestamps
    end
  end

  def self.down
    drop_table :ricfiles
  end
end
