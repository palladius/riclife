class HoboDroppaRiclocations < ActiveRecord::Migration
  def self.up
    drop_table :riclocations
  end

  def self.down
    create_table "riclocations", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.string   "x"
      t.string   "y"
      t.string   "address"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
