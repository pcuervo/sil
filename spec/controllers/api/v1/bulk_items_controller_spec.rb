require 'spec_helper'

describe Api::V1::BulkItemsController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @bulk_item = FactoryGirl.create :bulk_item
      get :show, id: @bulk_item.id
    end

    it "returns the information about a bulk_item in JSON format" do
      bulk_item_response = json_response[:bulk_item]
      expect(bulk_item_response[:quantity]).to eql @bulk_item.quantity
    end

    it "should have all the attributes of an inventory_item" do
      bulk_item_response = json_response[:bulk_item]
      expect(bulk_item_response[:name]).to eql @bulk_item.name
      expect(bulk_item_response[:description]).to eql @bulk_item.description
      expect(bulk_item_response[:image_url]).to eql @bulk_item.image_url
      expect(bulk_item_response[:status]).to eql @bulk_item.status
      expect(bulk_item_response[:barcode]).to eql @bulk_item.barcode
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      5.times{ FactoryGirl.create :bulk_item }
      get :index
    end

    it "returns 5 unit items from the database" do
      bulk_items_response = json_response
      expect(bulk_items_response[:bulk_items].size).to eq(5)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is succesfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        project = FactoryGirl.create :project

        @bulk_item_attributes = FactoryGirl.attributes_for :bulk_item
        @bulk_item_attributes[:project_id] = project.id

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, bulk_item: @bulk_item_attributes, :entry_date => Time.now, :storage_type => 'Permanente', :delivery_company => 'DHL' }
      end

      it "renders the json representation for the inventory item just created" do
        bulk_item_response = json_response[:bulk_item]
        expect(bulk_item_response[:name]).to eql @bulk_item_attributes[:name]
      end

      it "should record the transaction in database" do
        bulk_item_response = json_response[:bulk_item]
        inv_item = InventoryItem.find_by_actable_id(bulk_item_response[:id])
        inv_transaction = InventoryTransaction.find_by_inventory_item_id(inv_item.id)
        expect(inv_transaction.to_json.size).to be >= 1
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_bulk_item_attributes = { user_id: user.id }

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, bulk_item: @invalid_bulk_item_attributes }
      end

      it "renders an errors json" do
        bulk_item_response = json_response
        expect(bulk_item_response).to have_key(:errors)
      end

      it "renders the json errors on why the inventory item could not be created" do
        bulk_item_response = json_response

        expect(bulk_item_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }

    end
  end
end
