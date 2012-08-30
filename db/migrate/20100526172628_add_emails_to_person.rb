class AddEmailsToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :work_email, :string
    add_column :people, :pers_email, :string
  end

  def self.down
    remove_column :people, :pers_email
    remove_column :people, :work_email
  end
end
