class ChangeTimeTypeToEvents < ActiveRecord::Migration
  def self.up
    change_column :events, :tstart, :timestamp # 1gen01 14:59 , :default => Time.now
    change_column :events, :tend,   :timestamp
  end

  def self.down
    change_column :events, :tend,   :time
    change_column :events, :tstart, :time   # 14:59
  end
end
