class AddSolvedToLoans < ActiveRecord::Migration
  def self.up
    add_column :loans, :solved, :boolean, :default => false
    add_column :loans, :starred, :boolean, :default => false
  end

  def self.down
    remove_column :loans, :starred
    remove_column :loans, :solved
  end
end
