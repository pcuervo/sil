require 'spec_helper'

describe Api::V1::InventoryTransactionsController do
  describe "GET #show" do
    before(:each) do
      @inventory_transaction = FactoryGirl.create :inventory_transaction
      get :show, id: @inventory_transaction.id
    end

    it "returns the information about an inventory transaction on a hash" do
      inventory_transaction_response = json_response
      expect(inventory_transaction_response[:concept]).to eql @inventory_transaction.concept
    end

    it { should respond_with 200 }
  end

end
