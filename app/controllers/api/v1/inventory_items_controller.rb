class Api::V1::InventoryItemsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
  respond_to :json

  def index
    respond_with InventoryItem.all
  end

  def show
    respond_with InventoryItem.find(params[:id])
  end

  def create
    inventory_item = InventoryItem.new(inventory_item_params)

    puts params.to_hash
    if inventory_item.save
      render json: inventory_item, status: 201, location: [:api, inventory_item]
    else
      render json: { errors: inventory_item.errors }, status: 422
    end
  end

  private

    def inventory_item_params
      params.require(:inventory_item).permit(:name, :description, :user_id)
    end

end
