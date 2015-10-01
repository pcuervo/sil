class Api::V1::ClientContactsController < ApplicationController
  respond_to :json

  def show
    c = ClientContact.find(params[:id])
    respond_with c
    #respond_with ClientContact.find(params[:id])
  end

  def index
    respond_with ClientContact.all
  end

  def create
    client = Client.find(params[:client_id])
    client_contact = client.client_contacts.build(client_contact_params)

    if client_contact.save
      log_action( current_user.id, 'ClientContact', 'Created client contact: "' + client_contact.first_name + ' ' + client_contact.last_name, client_contact.id )
      render json: client_contact, status: 201, location: [:api, client_contact] 
      return 
    end

    render json: { errors: client_contact.errors }, status: 422
  end

  def update
    client_contact = ClientContact.find(params[:id])

    if client_contact.update(client_contact_params)
      log_action( current_user.id, 'ClientContact', 'Updated client contact: "' + client_contact.first_name + ' ' + client_contact.last_name, client_contact.id )
      render json: client_contact, status: 201, location: [:api, client_contact]
      return
    end

    render json: { errors: client_contact.errors }, status: 422
  end

  def destroy
    client_contact = ClientContact.find(params[:id])
    log_action( current_user.id, 'ClientContact', 'Deleted client contact: "' + client_contact.first_name + ' ' + client_contact.last_name, client_contact.id )
    client_contact.destroy
    head 204
  end

  private 

  def client_contact_params
    params.require(:client_contact).permit(:first_name, :last_name, :phone, :phone_ext, :email, :business_unit, :client_id)
  end
end
