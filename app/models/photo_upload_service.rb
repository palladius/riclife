class PhotoUploadService

  attr_reader :photo_type, :photo

  def initialize(photo_type,photo)
    @photo_type = photo_type
    @photo = photo
  end

  def save
    return false unless valid?
    begin
      PhotoType.transaction do
        if @photo.new_record?
          @photo_type.photo.destroy if @photo_type.photo
          @photo.photo_type = @photo_type
          @photo.save!
        end
        @photo_type.save!
        true
      end
    rescue
      false
    end
  end

  def update_attributes(photo_type_attributes, cover_file)
    @photo_type.attributes = photo_type_attributes
    unless cover_file.blank?
      @photo = Photo.new(:uploaded_data => cover_file )
    end
    save
  end

  # both valids
  def valid?
    @photo_type.valid? && @photo.valid?
  end


end