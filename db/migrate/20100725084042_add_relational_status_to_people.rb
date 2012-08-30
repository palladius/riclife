class AddRelationalStatusToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :relational_status, :string # , :default => 'dont_know'
  end

  def self.down
    remove_column :people, :relational_status
  end
end
