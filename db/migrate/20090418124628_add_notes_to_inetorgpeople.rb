# DovevoFarlaAlSingolare

class AddNotesToInetorgpeople< ActiveRecord::Migration
  def self.up
    add_column :inetorgpeople, :notes, :text
  end

  def self.down
    remove_column :inetorgpeople, :notes
  end
end
