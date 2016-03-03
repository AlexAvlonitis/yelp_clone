class RestaurantsController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if user_owns_restaurant?
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    else
      flash[:notice] = 'Cannot delete a restaurant that you did not add'
    end
    redirect_to '/restaurants'
  end

  def update
    @restaurant = Restaurant.find(params[:id])
   if user_owns_restaurant?
     @restaurant.update(restaurant_params)
   else
     flash[:notice] = 'You cannot edit a restaurant that you did not create'
   end
   redirect_to '/restaurants'
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def user_owns_restaurant?
    @restaurant.user == current_user
  end
end
