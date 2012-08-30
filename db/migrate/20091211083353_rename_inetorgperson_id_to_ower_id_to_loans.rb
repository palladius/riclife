class RenameInetorgpersonIdToOwerIdToLoans < ActiveRecord::Migration
  def self.up
      rename_column :loans,  :inetorgperson_id, :ower_id
  end

  def self.down
    rename_column :loans, :ower_id, :inetorgperson_id
  end
end
