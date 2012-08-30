class CreateLoans < ActiveRecord::Migration
  def self.up
    create_table :loans do |t|
      t.string :title
      t.text :description
      t.float :quantity
      t.string :currency
      t.integer :user_from_id
      t.integer :user_to_id

      t.timestamps
    end
  end

  def self.down
    drop_table :loans
  end
end
