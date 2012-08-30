class AddUrlIconToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :icon_path, :string
    add_column :venues, :icon_path, :string
  end

  def self.down
    remove_column :venues, :icon_path
    remove_column :events, :icon_path
  end
end
