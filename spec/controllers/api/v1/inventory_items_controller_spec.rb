require 'spec_helper'

describe Api::V1::InventoryItemsController do
  describe "GET #show" do
    before(:each) do
      @inventory_item = FactoryGirl.create :inventory_item
      get :show, id: @inventory_item.id
    end

    it "returns the information about an inventory item on a hash" do
      inventory_item_response = json_response
      expect(inventory_item_response[:name]).to eql @inventory_item.name
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      5.times{ FactoryGirl.create :inventory_item }
      get :index
    end

    it "returns 5 inventory items from the database" do
      inventory_items_response = json_response
      expect(inventory_items_response[:inventory_items].size).to eq(5)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is succesfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        project = FactoryGirl.create :project
        client = FactoryGirl.create :client

        @inventory_item_attributes = FactoryGirl.attributes_for :inventory_item
        @inventory_item_attributes[:project_id] = project.id
        @inventory_item_attributes[:client_id] = client.id

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, inventory_item: @inventory_item_attributes, item_img_ext: 'jpg' }
      end

      it "renders the json representation for the inventory item just created" do
        inventory_item_response = json_response
        expect(inventory_item_response[:name]).to eql @inventory_item_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_inventory_item_attributes = { user_id: user.id }

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, inventory_item: @invalid_inventory_item_attributes, item_img_ext: 'jpg' }
      end

      it "renders an errors json" do
        inventory_item_response = json_response
        expect(inventory_item_response).to have_key(:errors)
      end

      it "renders the json errors on why the inventory item could not be created" do
        inventory_item_response = json_response

        expect(inventory_item_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }

    end
  end

end
