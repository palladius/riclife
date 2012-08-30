 # # GET /magic_urls
  # # GET /magic_urls.xml
  # def index
  #   @magic_urls = MagicUrl.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @magic_urls }
  #   end
  # end
  # 
  # # GET /magic_urls/1
  # # GET /magic_urls/1.xml
  # def show
  #   @magic_url = MagicUrl.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @magic_url }
  #   end
  # end
  # 
  # # GET /magic_urls/new
  # # GET /magic_urls/new.xml
  # def new
  #   @magic_url = MagicUrl.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @magic_url }
  #   end
  # end
  # 
  # # GET /magic_urls/1/edit
  # def edit
  #   @magic_url = MagicUrl.find(params[:id])
  # end
  # 
  # # POST /magic_urls
  # # POST /magic_urls.xml
  # def create
  #   @magic_url = MagicUrl.new(params[:magic_url])
  # 
  #   respond_to do |format|
  #     if @magic_url.save
  #       flash[:notice] = 'MagicUrl was successfully created.'
  #       format.html { redirect_to(@magic_url) }
  #       format.xml  { render :xml => @magic_url, :status => :created, :location => @magic_url }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @magic_url.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # PUT /magic_urls/1
  # # PUT /magic_urls/1.xml
  # def update
  #   @magic_url = MagicUrl.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @magic_url.update_attributes(params[:magic_url])
  #       flash[:notice] = 'MagicUrl was successfully updated.'
  #       format.html { redirect_to(@magic_url) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @magic_url.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /magic_urls/1
  # # DELETE /magic_urls/1.xml
  # def destroy
  #   @magic_url = MagicUrl.find(params[:id])
  #   @magic_url.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(magic_urls_url) }
  #     format.xml  { head :ok }
  #   end
  # end


