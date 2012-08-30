class AddTagsToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :tags, :string, :default => 'doc'
  end

  def self.down
    remove_column :pages, :tags
  end
end
