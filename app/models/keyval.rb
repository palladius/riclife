class Keyval < ActiveRecord::Base

  validates_uniqueness_of :key
  searchable_by :key

  def to_s
    self.key
#    "#{@key} => #{val}"
  end

  # sara' fico o no?
  def self.add(k,v, desc='Description not provided for this keyval :)')
    self.create( :key => k ,  :val => v, :description => desc )
  end

  # mefistofelico, sono TROPPO ruby ormai...
  def self.add!(k,v, desc='Description not provided for this keyval :)')
    self.delete_all( ["key = ?", k] ) # if any..
    self.create!( :key => k ,  :val => v, :description => desc )
  end

  def self.get(k)
    find_by_key(k).val rescue nil
  end

  def self.append(k,v)
    existing_keyval = Keyval.find_by_key(k)
    if existing_keyval
      old_value = existing_keyval.val
      Keyval.update(existing_keyval.id, :val => old_value.to_s + "\n" + v.to_s )
    else
      add(k,v)
    end
  end

  def self.capistrano_update(comment='nope')
    line = "#{Time.now} '#{comment}'"
    Keyval.append 'cap:deploy_history', line
    Keyval.add!   'cap:deploy_last',    line
  end

end
