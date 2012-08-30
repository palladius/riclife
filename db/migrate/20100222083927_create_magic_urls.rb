class CreateMagicUrls < ActiveRecord::Migration
  def self.up
    create_table :magic_urls do |t|
      t.string :url
      t.text :description
      t.integer :privacy,   :default => 1
      t.integer :user_id
      t.boolean :active,    :default => true
      t.string :type,       :default => "MagicUrl"

      t.timestamps
    end
  end

  def self.down
    drop_table :magic_urls
  end
end
