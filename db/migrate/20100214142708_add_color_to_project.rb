class AddColorToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :color, :string,    :default => 'navy'
    add_column :calendars, :color, :string,   :default => 'navy'
  end

  def self.down
    remove_column :calendars, :color
    remove_column :projects, :color
  end
end
