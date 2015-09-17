class Api::V1::ClientsController < ApplicationController
  respond_to :json

  def show
    respond_with Client.find(params[:id])
  end

  def index
    respond_with Client.all
  end
end
