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
end
