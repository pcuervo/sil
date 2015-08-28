class Api::V1::InventoryItemsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
  respond_to :json

  def index
    respond_with UnitItem.all
  end

  def show
    respond_with UnitItem.find(params[:id])
  end

  def show_unit_item
    respond_with UnitItem.find(params[:id])
  end

  def create
    unit_item = UnitItem.new(unit_item_params)
    if unit_item.save
      inventory_item = InventoryItem.where('actable_id = ?', unit_item.id).first
      render json: unit_item, status: 201, location: [:api, inventory_item]
    else
      render json: { errors: unit_item.errors }, status: 422
    end
  end

  private

    def unit_item_params
      #puts params.to_yaml
      params.require(:unit_item).permit( :name, :description, :image_url, :status, :user_id, :serial_number, :brand, :model )
    end

end
