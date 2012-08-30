class RenameStartEndInEvents < ActiveRecord::Migration
  def self.up
		rename_column :events, :start, :tstart
		rename_column :events, :end, :tend
  end

  def self.down
		rename_column :events, :tend, :end
		rename_column :events, :tstart, :start
  end
end
