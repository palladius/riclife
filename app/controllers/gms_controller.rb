
class GmsController < ApplicationController
  def index
    @user = current_user() # resituisce anonimo o
    current_user_id = (@user.id rescue -1) 
    @gms      = Gms.find(:all, :conditions => ['to_id = (?)',   current_user_id ], :limit => 15) rescue [ Gms.last ]
    @sent_gms = Gms.find(:all, :conditions => ['from_id = (?)', current_user_id ], :limit => 15) rescue [ Gms.last ]
  end
  
  def show
    @gms = Gms.find(params[:id])
  end
  
  def new
    @gms = Gms.new
  end
  
  def create
    @gms = Gms.new(params[:gms])
    if @gms.save
      flash[:notice] = "Successfully created gms."
      redirect_to @gms
    else
      render :action => 'new'
    end
  end
  
  def edit
    @gms = Gms.find(params[:id])
  end
  
  def update
    @gms = Gms.find(params[:id])
    if @gms.update_attributes(params[:gms])
      flash[:notice] = "Successfully updated gms."
      redirect_to @gms
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @gms = Gms.find(params[:id])
    @gms.destroy
    flash[:notice] = "Successfully destroyed gms."
    redirect_to gms_url
  end
end
