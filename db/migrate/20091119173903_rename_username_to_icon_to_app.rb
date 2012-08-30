class RenameUsernameToIconToApp < ActiveRecord::Migration

  @app_names = [ 'googletalk' , 'facebook' ,'gpg', 'skype' , 'msn' , 'skype' , 'goliardia' , 'twitter', 'riclife', 'youtube', 'flickr', 'picasa', 'linkedin' ]

  def self.up
    rename_column :apps, :username, :icon # lo user lo sposto nella MoltiMolti! Qui non ha proprio senso
    @app_names.each { |x|
          App.create( :name => x, :description => "Added thru migration.." , :icon => "#{x}.png" , :url => "http://www.#{x}.com/", :local_path => "http://www.#{x}.com/___UID___" )
    }
  end

  def self.down
    rename_column :apps, :icon, :username # lo user lo sposto nella MoltiMolti! Qui non ha proprio senso
    @app_names.each { |x| App.find_by_name(x).delete rescue nil }
  end
  
end