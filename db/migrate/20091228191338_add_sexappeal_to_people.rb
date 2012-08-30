class AddSexappealToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :sexappeal, :integer, :default => 60
  end

  def self.down
    remove_column :people, :sexappeal
  end
end
