class AddAuditingToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :created_by, :string
    add_column :people, :updated_by, :string
  end

  def self.down
    remove_column :people, :updated_by
    remove_column :people, :created_by
  end
end
