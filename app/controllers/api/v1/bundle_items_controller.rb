class Api::V1::BundleItemsController < ApplicationController
  respond_to :json

  def show
    respond_with BundleItem.find(params[:id])
  end

  def index
    respond_with BundleItem.all
  end

  def create

    bundle_item = BundleItem.new(bundle_item_params)
    bundle_item.user = current_user

    if ! params[:parts].present?
      bundle_item.errors.add(:parts, 'cannot be empty')
      render json: { errors: bundle_item.errors }, status: 422
      return
    end

    # Paperclip adaptor 
    item_img = Paperclip.io_adapters.for(params[:item_img])
    item_img.original_filename = params[:filename]
    bundle_item.item_img = item_img

    if bundle_item.save
      bundle_item.add_parts( params[:parts] )
      inventory_item = InventoryItem.find_by_actable_id(bundle_item.id)
      log_transaction( params[:entry_date], inventory_item.id, "Entrada paquete", params[:storage_type], params[:estimated_issue_date], params[:additional_comments], params[:delivery_company], params[:delivery_company_contact] )
      log_action( current_user.id, 'InventoryItem', 'Created bundle item "' + bundle_item.name + '"', inventory_item.id )
      render json: bundle_item, status: 201, location: [:api, bundle_item]
    else
      render json: { errors: bundle_item.errors }, status: 422
    end
  end

  private 

    def bundle_item_params
      params.require(:bundle_item).permit(:quantity, :name, :description, :project_id, :status, :item_type, :barcode)
    end

end
