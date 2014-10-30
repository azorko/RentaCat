class CatRentalRequestsController < ApplicationController
  
  before_action :ensure_cat_ownership, only: [:approve, :deny]
  
  def new
    @cats = Cat.all
    @crr = CatRentalRequest.new
    render :new
  end
  
  def create
    @crr = current_user.cat_rental_requests.new(crr_params)
    
    if @crr.save
      redirect_to cat_url(@crr.cat_id)
    else
      flash.now[:errors] = @crr.errors.full_messages
      render :new
    end
  end
  
  def approve
    byebug
    @crr = CatRentalRequest.find(params[:cat_rental_request_id])
    @crr.approve!
    redirect_to cats_url
  end
  
  def deny
    @crr = CatRentalRequest.find(params[:cat_rental_request_id])
    @crr.deny!
    redirect_to cats_url
  end
  
  def crr_params
    args = [:cat_id, :start_date, :end_date, :status]
    params.require(:cat_rental_request).permit(*args)
  end
    
  def ensure_cat_ownership
    if current_user.id != params[:cat_rental_request_id].to_i
      flash.now[:errors] = "You cannot approve requests for another user's cat." ##does not work
    # @crr = CatRentalRequest.new(crr_params)
 #    @crr.errors[:user_id] << "You cannot approve requests for another user's cat."
 #    @crr.flash.now = @crr.errors[:user_id]
      redirect_to cats_url
    else
      return
    end
  end
    
  
end
