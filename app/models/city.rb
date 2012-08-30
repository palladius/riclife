class City < ActiveRecord::Base
  searchable_by :name
  attr_accessible :nomecitta, :sigla, :regione, :id_pseudoid #, :created_at, :updated_at
  
  validates_length_of       :sigla,    :within => 2..2

  def to_s
    name
  end
  
end
