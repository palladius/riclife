class AddPriceToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :price, :float
  end

  def self.down
    remove_column :events, :price
  end
end
