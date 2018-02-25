class Page < ActiveRecord::Base
  belongs_to :person
  
  @@description = "This class aims to provide a blog-style thing 1"
  
  searchable_by :tags, :title, :header, :body
  
  def to_s
    title
  end
  
  def self.description
#    @@description
    "This class aims to provide a blog-style thing 2"
  end
  
end