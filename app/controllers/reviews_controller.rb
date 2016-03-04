class ReviewsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find params[:restaurant_id]
    @review = @restaurant.build_review review_params, current_user

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if user_owns_review?
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
    else
      flash[:notice] = 'Cannot delete this review as you did not add it'
    end
    redirect_to '/restaurants'
  end

  def user_owns_review?
    @review.user == current_user
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
