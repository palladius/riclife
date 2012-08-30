class RicfilesController < ApplicationController
  before_filter :login_required
  # GET /ricfiles
  # GET /ricfiles.xml
  def index
    @ricfiles = Ricfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ricfiles }
    end
  end

  # GET /ricfiles/1
  # GET /ricfiles/1.xml
  def show
    @ricfile = Ricfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ricfile }
    end
  end

  # GET /ricfiles/new
  # GET /ricfiles/new.xml
  def new
    @ricfile = Ricfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ricfile }
    end
  end

  # GET /ricfiles/1/edit
  def edit
    @ricfile = Ricfile.find(params[:id])
  end

  # POST /ricfiles
  # POST /ricfiles.xml
  def create
    @ricfile = Ricfile.new(params[:ricfile])

    respond_to do |format|
      if @ricfile.save
        flash[:notice] = 'Ricfile was successfully created.'
        format.html { redirect_to(@ricfile) }
        format.xml  { render :xml => @ricfile, :status => :created, :location => @ricfile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ricfile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ricfiles/1
  # PUT /ricfiles/1.xml
  def update
    @ricfile = Ricfile.find(params[:id])

    respond_to do |format|
      if @ricfile.update_attributes(params[:ricfile])
        flash[:notice] = 'Ricfile was successfully updated.'
        format.html { redirect_to(@ricfile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ricfile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ricfiles/1
  # DELETE /ricfiles/1.xml
  def destroy
    @ricfile = Ricfile.find(params[:id])
    @ricfile.destroy

    respond_to do |format|
      format.html { redirect_to(ricfiles_url) }
      format.xml  { head :ok }
    end
  end
end
