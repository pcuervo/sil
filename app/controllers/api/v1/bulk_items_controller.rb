class Api::V1::BulkItemsController < ApplicationController
respond_to :json
  
  def show
    respond_with BulkItem.find(params[:id])
  end

  def index
    respond_with BulkItem.all
  end

  def create

    bulk_item = BulkItem.new(bulk_item_params)
    bulk_item.user = current_user

    # Paperclip adaptor 
    item_img = Paperclip.io_adapters.for(params[:item_img])
    item_img.original_filename = params[:filename]
    bulk_item.item_img = item_img

    if bulk_item.save
      inventory_item = InventoryItem.find_by_actable_id(bulk_item.id)
      log_transaction( params[:entry_date], inventory_item.id, "Entrada granel", params[:storage_type], params[:estimated_issue_date], params[:additional_comments], params[:delivery_company], params[:delivery_company_contact])
      log_action( current_user.id, 'InventoryItem', 'Created bulk item "' + bulk_item.name + '"', inventory_item.id )
      render json: bulk_item, status: 201, location: [:api, bulk_item]
    else
      render json: { errors: bulk_item.errors }, status: 422
    end
  end

  private

    def bulk_item_params
      params.require(:bulk_item).permit(:quantity, :name, :description, :project_id, :status, :item_type, :barcode)
    end
end

