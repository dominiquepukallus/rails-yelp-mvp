class ReviewsController < ApplicationController
  # We need to find the restaurant associated with the review
  before_action :set_restaurant, only: %i[new create]

  # create a get request to see the reviews, define what the restaurant id
  def new
    # need this @ for our simple form. new renders form
    @restaurant = Restaurant.find(params[:restaurant_id])
    # create a new review
    @review = Review.new
  end

  # create a post request to create a new review
  # status: :unprocessable_entity responds with a 422 HTTP status code
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_permits)
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_permits
    params.require(:review).permit(:content, :rating)
  end
end
