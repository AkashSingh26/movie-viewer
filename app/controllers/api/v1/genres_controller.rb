class Api::V1::GenresController < ApplicationController
  before_action :set_api_v1_genre, only: [:show, :update, :destroy]

  # GET /api/v1/genres
  def index
    @api_v1_genres = Api::V1::Genre.all

    render json: @api_v1_genres
  end

  # GET /api/v1/genres/1
  def show
    render json: @api_v1_genre
  end

  # POST /api/v1/genres
  def create
    @api_v1_genre = Api::V1::Genre.new(api_v1_genre_params)

    if @api_v1_genre.save
      render json: @api_v1_genre, status: :created, location: @api_v1_genre
    else
      render json: @api_v1_genre.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/genres/1
  def update
    if @api_v1_genre.update(api_v1_genre_params)
      render json: @api_v1_genre
    else
      render json: @api_v1_genre.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/genres/1
  def destroy
    @api_v1_genre.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_genre
      @api_v1_genre = Api::V1::Genre.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_genre_params
      params.fetch(:api_v1_genre, {})
    end
end
