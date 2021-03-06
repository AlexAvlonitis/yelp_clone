class EndorsementsController < ApplicationController

  def new
    @review = Review.find(params[:review_id])
  end

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    render json: {new_endorsement_count: @review.endorsements.count}
  end

end
