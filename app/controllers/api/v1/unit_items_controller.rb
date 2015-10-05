class Api::V1::UnitItemsController < ApplicationController
  respond_to :json
  
  def show
    respond_with UnitItem.find(params[:id])
  end

  def index
    respond_with UnitItem.all
  end

  def create

    unit_item = UnitItem.new(unit_item_params)
    unit_item.user = current_user

    # Paperclip adaptor 
    item_img = Paperclip.io_adapters.for(params[:item_img])
    item_img.original_filename = params[:filename]
    unit_item.item_img = item_img

    if unit_item.save
      render json: unit_item, status: 201, location: [:api, unit_item]
    else
      render json: { errors: unit_item.errors }, status: 422
    end
  end

  private

    def unit_item_params
      params.permit(:serial_number, :brand, :model, :name, :description, :project_id, :image_url, :status, :item_img)
    end
end
