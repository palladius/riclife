class PhotoTypesController < ApplicationController
  # GET /photo_types
  # GET /photo_types.xml
  def index
    @photo_types = PhotoType.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photo_types }
    end
  end

  # GET /photo_types/1
  # GET /photo_types/1.xml
  def show
    @photo_type = PhotoType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo_type }
    end
  end

  # GET /photo_types/new
  # GET /photo_types/new.xml
  def new
    @photo_type = PhotoType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo_type }
    end
  end

  # GET /photo_types/1/edit
  def edit
    @photo_type = PhotoType.find(params[:id])
  end

  # Modifico per Upload!
  def create
    @photo_type = PhotoType.new(params[:photo_type])
    @photo = Photo.new( :uploaded_data => params[:photo_file] )
    @service = PhotoUploadService.new(@photo_type, @photo)

    respond_to do |format|
      if @service.save
        flash[:notice] = 'PhotoType and Photo were successfully created.'
        format.html { redirect_to(@photo_type) }
        format.xml  { render :xml => @photo_type, :status => :created, :location => @photo_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photo_types/1
  # PUT /photo_types/1.xml
  def update
    @photo_type = PhotoType.find(params[:id])
    @photo = @photo_type.photo
    @service = PhotoUploadService.new(@photo_type, @photo)

    respond_to do |format|
      if @service.update_attributes(params[:photo_type], params[:photo_file])
        flash[:notice] = 'PhotoType and Photo were successfully updated.'
        format.html { redirect_to(@photo_type) }
        format.xml  { head :ok }
      else
        @photo = @photo_type.photo
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photo_types/1
  # DELETE /photo_types/1.xml
  def destroy
    @photo_type = PhotoType.find(params[:id])
    @photo_type.destroy

    respond_to do |format|
      format.html { redirect_to(photo_types_url) }
      format.xml  { head :ok }
    end
  end
end
