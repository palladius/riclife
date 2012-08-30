class PhotosController < ApplicationController

  #@photos, @photo = paginate :photo, :per_page => 100

  active_scaffold :photo do |config|
			list.columns.exclude :created_at, :updated_at , 
			  :content_type, :width, :height, :filename, :notes
      list.columns.add     :fotina, :wxh
      list.per_page = 1000
  end

end
