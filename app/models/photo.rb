class Photo < ActiveRecord::Base
  belongs_to :photo_type

  searchable_by :filename, :notes, :thumbnail

  has_attachment :content_type => :image,
    :storage => :file_system,
    :max_size =>  1000.kilobytes,
    :resize_to => '800x600',

      # cambiati da me, vedi:
      # http://wiki.github.com/technoweenie/attachment_fu
    :path_prefix => "public/system/upload/photos/", #"#{table_name}/",
    # :partition => false, # sarebbe true

    :thumbnails => {
      :large =>  '200x200',
      #      :medium => '64x64',
      :small  =>  '48x48',
      :ric150 => '150x150'
    }

  validates_as_attachment

  def to_label
    filename
  end

  def to_s
    filename
  end

end
