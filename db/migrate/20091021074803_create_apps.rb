class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :name
      t.text :description
      t.integer :host_id
      t.string :url
      t.string :db_uri
      t.string :local_path
      t.string :svn_uri
      t.string :language

      t.timestamps
    end
  end

  def self.down
    drop_table :apps
  end
end
