class AddContactStuffToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :contact_email, :string
    add_column :events, :contact_phone, :string
    rename_column :events, :status, :repeat_frequency 
  end

  def self.down
    rename_column :events, :repeat_frequency, :status 
    remove_column :events, :contact_phone
    remove_column :events, :contact_email
  end
end
