class AddStuffToVenues < ActiveRecord::Migration
  def self.up
    add_column :venues, :description, :text
    add_column :venues, :url, :string
  end

  def self.down
    remove_column :venues, :url
    remove_column :venues, :description
  end
end
