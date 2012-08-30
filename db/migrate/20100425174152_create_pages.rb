class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.text :header
      t.text :body
      t.integer :person_id
      t.public  :boolean,   :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
