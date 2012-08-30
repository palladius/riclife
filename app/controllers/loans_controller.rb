class LoansController < ApplicationController
  before_filter :login_required
  
  # active_scaffold :loan do |config|
  #   list.columns.exclude :created_at, :updated_at, :currency, :description,
  #     :date_start, :date_end, :recurs_days, :tags, :type, :solved, :comments
  #   list.columns.add :people_involved # :creditor , :ower, 
  #   config.columns[:ower].form_ui = :select
  #   config.columns[:creditor].form_ui = :select
  #   
  #   config.columns[:quantity].calculate = :sum
  #   # cool
  #   config.create.columns.exclude :comments,
  #      :date_start, :date_end, :recurs_days, :type,
  #      :solved, :currency, :active
  #  end
   
    # TBD devi togliere lo scaffolding affinche funzioni!
   def new
     @loan = Loan.new(
      :ower_id     => params[:ower_id    ],
      :creditor_id => params[:creditor_id],
      :tags        => params[:tags       ],
      :description => params[:description]
     )
   end
   
   def conditions_for_collection
     ['solved = (?)', false ]
   #   ['tend > (?)', Time.now() ]
   end

   def index
#     @loans = Loan.all
     @loans = Loan.find_all_by_solved(false)
   end

   def show
     @loan = Loan.find(params[:id])
   end

   # def new
   #   @loan = Loan.new
   # end

   def create
     @loan = Loan.new(params[:loan])
     if @loan.save
       flash[:notice] = "Successfully created loan."
       redirect_to @loan
     else
       render :action => 'new'
     end
   end

   def edit
     @loan = Loan.find(params[:id])
   end

   def update
     @loan = Loan.find(params[:id])
     if @loan.update_attributes(params[:loan])
       flash[:notice] = "Successfully updated loan."
       redirect_to @loan
     else
       render :action => 'edit'
     end
   end

   def destroy
     @loan = Loan.find(params[:id])
     @loan.destroy
     flash[:notice] = "Successfully destroyed loan."
     redirect_to loans_url
   end


end