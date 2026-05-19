class RestaurantsController < ApplicationController
  # create a get request to view restaurants
  def index
   @restaurant = Restaurant.all
  end

  # show the restaurants
  def show
    @restaurant = Restaurant.find(params[:id])
  end

  # add a new restaurant to the list then show that new restaurant. Create is always two actions for one user story
  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_permits)
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def restaurant_permits
    params.require(:restaurant).permit(:name, :address, :category)
  end
end
