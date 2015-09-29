class Api::V1::InventoryItemsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
  respond_to :json

  def index
    respond_with InventoryItem.order('created_at DESC').all
  end

  def show
    respond_with InventoryItem.find(params[:id])
  end

  def create
    #inventory_item = InventoryItem.new(inventory_item_params)
    inventory_item = current_user.inventory_items.build(inventory_item_params)

    if inventory_item.save
      render json: inventory_item, status: 201, location: [:api, inventory_item]
    else
      render json: { errors: inventory_item.errors }, status: 422
    end
  end

  private

    def inventory_item_params
      puts params.to_yaml
      params.require(:inventory_item).permit(:name, :description, :project_id, :client_id, :status)
    end

end
