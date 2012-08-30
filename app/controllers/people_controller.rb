class PeopleController < ApplicationController
  
    include AuthenticatedSystem
    helper WikiHelper
    
  before_filter :login_required

  # http://ym4r.rubyforge.org/ym4r_mapstraction-doc/
  def gmap_index
    @user = current_user
    @people = Person.all
    @map = gmap_create("venue_map_div")
    @people.each{|person| 
      if person.venue
        add_to_map(person,@map)
       end
      }
  end
  
  def index
    @people = Person.all # ( :limit => 5 ) # rimuovi in production
    @npeople = 15
    @last_people = Person.all( :order => 'updated_at DESC', :limit => @npeople ) # rimuovi in production
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @people }
    end
  end
  
  def show
    @person = Person.find(params[:id])
    @current_user = current_user rescue nil
    @creditor_loans  = anonimo? ? 
      [] :
      Loan.find_all_by_creditor_id_and_solved(params[:id],false)
    @debtor_loans   = anonimo? ? 
        [] :
        Loan.find_all_by_ower_id_and_solved(params[:id], false)
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @person }
    end
  end
  
  # # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  def new_nonva_porca_pupazza
    @person= Person.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @person }
    end
  end
  
  def update
     @person = Person.find(params[:id])
     respond_to do |format|
       if @person.update_attributes(params[:person])
         flash[:notice] = "Person ##{@person.id} was successfully updated 1: #{ params[:person].inspect }."
         invalidate_cache
         format.html { redirect_to(@person) }
         format.xml  { head :ok }
         format.js   { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml    => @person.errors, 
                              :status => :unprocessable_entity }
         format.js   { head :unprocessable_entity }
       end
     end
   end
    
    def new
      @person = Person.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @person }
      end
    end

    # # POST /people
    # # POST /person.xml
    def create
        # non serve, lo fa il modello!
#      params[:person][:created_by] = current_user.name rescue "DunnoEither_#{$!}"
      @person = Person.new(params[:person])
      respond_to do |format|
        if @person.save
          flash[:notice] = 'Person was successfully created.'
          invalidate_cache
          format.html { redirect_to(@person) }
          format.xml  { render :xml => @person, :status => :created, :location => @person }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
        end
      end
    end

    # # DELETE /people/1
    # # DELETE /people/1.xml
    def destroy
      @person = Person.find(params[:id])
      @person.destroy
      respond_to do |format|
        format.html { redirect_to(people_url) }
        format.xml  { head :ok }
      end
    end
end
