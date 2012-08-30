class AddEmailAndPhoneToVenue < ActiveRecord::Migration
  def self.up
    add_column :venues, :mail, :string
    add_column :venues, :phone, :string
  end

  def self.down
    remove_column :venues, :phone
    remove_column :venues, :mail
  end
end
