=begin
  Cazzo ci stavo ricascando ricreando i BOOKMARK
  
  class CreateBookmarks < ActiveRecord::Migration
    def self.up
      create_table :bookmarks do |t|
        t.string :host
        t.string :path
        t.string :tags
        t.text :notes
        t.text :auto_notes
        t.text :poly_notes
        t.string :username
        t.timestamps
      end
    end

    def self.down
      drop_table :bookmarks
    end
  end
  
=end

class Ricfile < ActiveRecord::Base
  
  searchable_by :host, :path, :tags, :metatags, :URI, :description 
  
end
