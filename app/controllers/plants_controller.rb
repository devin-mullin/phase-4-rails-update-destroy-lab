class PlantsController < ApplicationController

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = plant_find
    render json: plant
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  def update 
    plant = plant_find
    plant.update(plant_params)
    render json: plant
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def destroy
    plant = plant_find
    plant.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def plant_find
    Plant.find_by(id: params[:id])
  end

  def render_not_found
    render json: { error: "Plant not found" }, status: :not_found
  end

end
