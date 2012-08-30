class MailingsController < ApplicationController
  helper :layout

  def deliver
#    call_rake :send_mailing, :mailing_id => params[:id], :comment => 'called by MailingsController su deliver()..'
    MailingsWorker.async_send_mailing(:mailing_is => params[:id], :comment => "a sto giro uso starling")
    flash[:notice] = "Delivering mailing..."
    redirect_to mailings_url
  end

#  active_scaffold :mailing do |config|
#    #list.columns.exclude :created_at, :updated_at, :currency, :description
#    #config.columns[:person].form_ui = :select
#  end


  # GET /mailings
  # GET /mailings.xml
  def index
    @mailings = Mailing.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mailings }
    end
  end

  # GET /mailings/1
  # GET /mailings/1.xml
  def show
    @mailing = Mailing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mailing }
    end
  end

  # GET /mailings/new
  # GET /mailings/new.xml
  def new
    @mailing = Mailing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mailing }
    end
  end

  # GET /mailings/1/edit
  def edit
    @mailing = Mailing.find(params[:id])
  end

  # POST /mailings
  # POST /mailings.xml
  def create
    @mailing = Mailing.new(params[:mailing])

    respond_to do |format|
      if @mailing.save
        flash[:notice] = 'Mailing was successfully created.'
        format.html { redirect_to(@mailing) }
        format.xml  { render :xml => @mailing, :status => :created, :location => @mailing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mailing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mailings/1
  # PUT /mailings/1.xml
  def update
    @mailing = Mailing.find(params[:id])

    respond_to do |format|
      if @mailing.update_attributes(params[:mailing])
        flash[:notice] = 'Mailing was successfully updated.'
        format.html { redirect_to(@mailing) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mailing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mailings/1
  # DELETE /mailings/1.xml
  def destroy
    @mailing = Mailing.find(params[:id])
    @mailing.destroy

    respond_to do |format|
      format.html { redirect_to(mailings_url) }
      format.xml  { head :ok }
    end
  end
end
