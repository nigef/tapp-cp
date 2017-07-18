class OffersController < ApplicationController
  protect_from_forgery with: :exception

  def index
    render json: Offer.all.to_json
  end

  def show
    render json: Offer.find(params[:id]).to_json
  end

  def show_by_instructor
    offer = Offer.find_by!(instructor_id: params[:instructor_id])
    render json: offer.to_json
  end
end