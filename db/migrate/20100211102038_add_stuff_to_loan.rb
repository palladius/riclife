class AddStuffToLoan < ActiveRecord::Migration
  def self.up
    add_column :loans, :recurs_days, :integer,    :default => 0
    add_column :loans, :loan_id, :integer,        :default => nil
    add_column :loans, :date_start, :date,        :default => nil
    add_column :loans, :date_end, :date,          :default => nil
    add_column :loans, :active, :boolean,         :default => true
    add_column :loans, :type, :string   # for STI in Loans!!! Cool
  end

  def self.down
    remove_column :loans, :type
    remove_column :loans, :active
    remove_column :loans, :date_end
    remove_column :loans, :date_start
    remove_column :loans, :loan_id
    remove_column :loans, :recurs_days
  end
end
