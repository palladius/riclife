class MagicUrl < ActiveRecord::Base
  
  DESCRIPTION = <<-FINE
    metti che quando salvi mette il current_user e tuto automatico.
  FINE
  
  searchable_by :url, :description
  
  
  def to_s
    url + "TBD(metti description nel titolo dello scaffolding, come descrizione del modello..)"
  end
  def name
    url
  end
  # link_to url
  
end
