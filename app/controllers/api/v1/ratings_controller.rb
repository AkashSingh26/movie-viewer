class Api::V1::RatingsController < ApplicationController
  before_action :set_api_v1_rating, only: [:show, :update, :destroy]

  # GET /api/v1/ratings
  def index
    @api_v1_ratings = Rating.all

    render json: @api_v1_ratings
  end

  # GET /api/v1/ratings/1
  def show
    render json: @api_v1_rating
  end

  # POST /api/v1/ratings
  def create
    @api_v1_rating = Rating.new(api_v1_rating_params)

    if @api_v1_rating.save
      render json: @api_v1_rating, status: :created, location: @api_v1_rating
    else
      render json: @api_v1_rating.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/ratings/1
  def update
    if @api_v1_rating.update(api_v1_rating_params)
      render json: @api_v1_rating
    else
      render json: @api_v1_rating.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/ratings/1
  def destroy
    @api_v1_rating.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_rating
      @api_v1_rating = Rating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_rating_params
      params.fetch(:api_v1_rating, {})
    end
end
