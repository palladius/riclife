class AddCreditorToLoans < ActiveRecord::Migration
  def self.up
    add_column :loans, :creditor_id, :integer
  end

  def self.down
    remove_column :loans, :creditor_id
  end
end
