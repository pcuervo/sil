class Api::V1::InventoryTransactionsController < ApplicationController
  respond_to :json
  
  def show
    respond_with InventoryTransaction.find(params[:id])
  end

  def index
    respond_with InventoryTransaction.order(entry_date: :desc).all
  end

end
