require 'spec_helper'

describe Api::V1::UnitItemsController do
  describe "GET #show" do
    before(:each) do
      @unit_item = FactoryGirl.create :unit_item
      get :show, id: @unit_item.id
    end

    it "returns the information about a unit_item in JSON format" do
      unit_item_response = json_response[:unit_item]
      expect(unit_item_response[:serial_number]).to eql @unit_item.serial_number
      expect(unit_item_response[:brand]).to eql @unit_item.brand
      expect(unit_item_response[:model]).to eql @unit_item.model
    end

    it "should have all the attributes of an inventory_item" do
      unit_item_response = json_response[:unit_item]
      expect(unit_item_response[:name]).to eql @unit_item.name
      expect(unit_item_response[:description]).to eql @unit_item.description
      expect(unit_item_response[:image_url]).to eql @unit_item.image_url
      expect(unit_item_response[:status]).to eql @unit_item.status
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      5.times{ FactoryGirl.create :unit_item }
      get :index
    end

    it "returns 5 unit items from the database" do
      unit_items_response = json_response
      expect(unit_items_response[:unit_items].size).to eq(5)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is succesfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        project = FactoryGirl.create :project

        @unit_item_attributes = FactoryGirl.attributes_for :unit_item
        @unit_item_attributes[:project_id] = project.id

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, unit_item: @unit_item_attributes, :entry_date => Time.now, :storage_type => 'Permanente', :delivery_company => 'DHL' }
      end

      it "renders the json representation for the inventory item just created" do
        unit_item_response = json_response[:unit_item]
        expect(unit_item_response[:name]).to eql @unit_item_attributes[:name]
      end

      it "should record the transaction in database" do
        unit_item_response = json_response[:unit_item]
        inv_item = InventoryItem.find_by_actable_id(unit_item_response[:id])
        inv_transaction = InventoryTransaction.find_by_inventory_item_id(inv_item.id)
        expect(inv_transaction.to_json.size).to be >= 1
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_unit_item_attributes = { user_id: user.id }

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, unit_item: @invalid_unit_item_attributes }
      end

      it "renders an errors json" do
        unit_item_response = json_response
        expect(unit_item_response).to have_key(:errors)
      end

      it "renders the json errors on why the inventory item could not be created" do
        unit_item_response = json_response

        expect(unit_item_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }

    end
  end
end
