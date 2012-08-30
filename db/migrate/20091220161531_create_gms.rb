class CreateGms < ActiveRecord::Migration
  def self.up
    create_table :gms do |t|
      t.string   :subject
      t.text     :body
      t.integer  :from_id
      t.integer  :to_id
      t.boolean :unread, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :gms
  end
end
