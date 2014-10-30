class CatsController < ApplicationController
  
  before_action :ensure_cat_ownership, only: [:edit, :update]
  
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    @crr = CatRentalRequest.where(cat_id: @cat.id)
    @crr = @crr.order(:start_date)
    render :show
  end
  
  def new
    @cat = Cat.new
    render :new
  end
  
  def create
    # @cats = Cat.all
    
    @cat = current_user.cats.new(cat_params)
    if @cat.save
      redirect_to cats_url
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end
  
  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end
  
  def ensure_cat_ownership
    errors[:user_id] << "You cannot edit another user's cat."
    flash.now = errors[:user_id]
    redirect_to cats_url if @current_user.id != params[:user_id]
  end
  
  def cat_params
    cat_attrs = [:birth_date, :color, :name, :sex, :description]
    params.require(:cat).permit(*cat_attrs)
  end
end
