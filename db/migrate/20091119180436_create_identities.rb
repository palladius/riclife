class CreateIdentities < ActiveRecord::Migration
  def self.up
    create_table :identities do |t|
      t.integer :inetorgperson_id
      t.integer :app_id
      t.string :uid
      t.text :description
      t.boolean :validated

      t.timestamps
    end
  end

  def self.down
    drop_table :identities
  end
end
