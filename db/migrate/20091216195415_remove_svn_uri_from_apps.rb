class RemoveSvnUriFromApps < ActiveRecord::Migration
  def self.up
    rename_column :apps, :host_id, :person_id # creator, host doesnt make sense anymore :)
    remove_column :apps, :language
    remove_column :apps, :svn_uri
    remove_column :apps, :db_uri
    rename_table :inetorgpeople, :people
  end

  def self.down
    rename_table :people, :inetorgpeople
    add_column :apps, :db_uri, :string
    add_column :apps, :svn_uri, :string
    add_column :apps, :language, :string
    rename_column :apps, :host_id, :person_id
  end
end
