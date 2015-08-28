require 'spec_helper'

describe Api::V1::InventoryItemsController do
  describe "GET #show" do
    before(:each) do
      @unit_item = FactoryGirl.create :unit_item
      get :show, id: @unit_item.id
    end

    it "returns the information about a unitary item on a hash" do
      unit_item_response = json_response
      expect(unit_item_response[:name]).to eql @unit_item.name
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
      expect(unit_items_response[:inventory_items].size).to eq(5)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is succesfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        #@unit_item_attributes = FactoryGirl.attributes_for :unit_item
        @unit_item_attributes = { :id => 1, :name => 'test_unit', :description => 'lorem', :user_id => 1  }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, unit_item: @unit_item_attributes }
      end

      it "renders the json representation for the unit item just created" do
        unit_item_response = json_response
        expect(unit_item_response[:name]).to eql @unit_item_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_unit_item_attributes = { serial_number: "hi mom", user_id: user.id }

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, unit_item: @invalid_unit_item_attributes }
      end

      it "renders an errors json" do
        unit_item_response = json_response
        expect(unit_item_response).to have_key(:errors)
      end

      it "renders the json errors on why the unit item could not be created" do
        unit_item_response = json_response
        expect(unit_item_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }

    end
  end

end
