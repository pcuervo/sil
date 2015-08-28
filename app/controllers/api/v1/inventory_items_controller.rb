class Api::V1::InventoryItemsController < ApplicationController
  respond_to :json

  def index
    respond_with UnitItem.all
  end

  def show
    respond_with UnitItem.find(params[:id])
  end

end
