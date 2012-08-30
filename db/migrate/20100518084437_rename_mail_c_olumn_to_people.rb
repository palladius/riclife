class RenameMailCOlumnToPeople < ActiveRecord::Migration
  def self.up
     rename_column :people, :mail, :email 
		 change_column :people, :published, :boolean, :default => true
		 change_column :people, :starred, :boolean, :default => false
		 change_column :people, :location, :string, :default => 'Dublin, Ireland'
  end

  def self.down
    rename_column :people, :email, :mail 
  end
end
