class AddRelevanceToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes,    :relevance, :integer,    :default => 30   # 10-30 (1=VERY IMPORTANT 2=medium 3=LOW PRI)
    add_column :notes,    :progress,  :integer,    :default => 0     # percentage 0..100 %
    add_column :notes,    :completed, :boolean,    :default => false # ACTIVE has semantics of visible/unvisible...
    add_column :projects, :public,    :boolean,    :default => true  # ALl his notes are public or not..
  end

  def self.down
    remove_column :projects, :public
    remove_column :notes, :completed
    remove_column :notes, :progress
    remove_column :notes, :relevance
  end
end
