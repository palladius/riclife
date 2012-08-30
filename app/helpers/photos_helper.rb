module PhotosHelper

  def fotina_column(r)
     image_tag( r.public_filename,   :height => 22 )#
  end
  def wxh_column(r)
    "#{r.width}x#{r.height}"
  end


end
