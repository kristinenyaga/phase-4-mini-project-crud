class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound,with: :render_not_found_response

rescue_from ActionController::RoutingError,with: ""
  def index
    spices = Spice.all

    render json: spices 
  end

  def show
    spice = find_spice
    render json: spice


  end

  def create

    spice = Spice.create(params_spice)
    render json: spice , status: :created
  end

  def update
    spice = find_spice
    spice.update(params_spice)
    render json: spice , status: :ok
  end

  def destroy
    spice = find_spice
    spice.destroy

    head :no_content
  end

  private 

  def find_spice
    Spice.find(params[:id])
  end

  def params_spice
    params.permit(:title, :image, :rating,:description,:notes)
  end

  def render_not_found_response
    render json: { error: "Spice not found" },status: :not_found
  end
end
