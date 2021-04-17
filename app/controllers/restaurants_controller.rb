class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update ]
  before_action :authenticate_user!, except: [:show, :index, :search]
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  # GET /restaurants or /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  def search
    if params[:restaurant][:name].blank? || params[:restaurant][:location].blank?
      redirect_to(restaurants_url, notice: "please enter a restaurant and location to search")
    else
      @restaurants = Restaurant.where("name like ? AND location like ?",
        "%#{params['restaurant']['name']}", "%#{params['restaurant']['location']}")

      if @restaurants.present?
        respond_to do |format|
            format.html { render :index }
        end
      else
        redirect_to(restaurants_url, notice: "That restaurant hasn't been added to our website yet.")
      end

    end
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end


  def upvote
    id = params[:restaurant_id]

    @restaurant = Restaurant.find(id)

    @restaurant[:upvotes] += 1

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurants_url, notice: "Vote successfully cast." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def downvote
    id = params[:restaurant_id]

    @restaurant = Restaurant.find(id)

    @restaurant[:downvotes] += 1

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurants_url, notice: "Vote successfully cast." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant}
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurants_url, notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :location, :upvotes, :downvotes)
    end
end
