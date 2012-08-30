class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :date_due            , :default => Time.now
      t.boolean :active           , :default => true
      t.boolean :todo             , :default => true
      t.integer :inetorgperson_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
