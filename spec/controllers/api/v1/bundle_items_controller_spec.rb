require 'spec_helper'

describe Api::V1::BundleItemsController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @bundle_item = FactoryGirl.create :bundle_item
      get :show, id: @bundle_item.id
    end

    it "returns the information about a bundle_item in JSON format" do
      bundle_item_response = json_response[:bundle_item]
      expect(bundle_item_response[:quantity]).to eql @bundle_item.quantity
    end

    it "should have all the attributes of an inventory_item" do
      bundle_item_response = json_response[:bundle_item]
      expect(bundle_item_response[:name]).to eql @bundle_item.name
      expect(bundle_item_response[:description]).to eql @bundle_item.description
      expect(bundle_item_response[:image_url]).to eql @bundle_item.image_url
      expect(bundle_item_response[:status]).to eql @bundle_item.status
      expect(bundle_item_response[:barcode]).to eql @bundle_item.barcode
    end

    it { should respond_with 200 }
  end
end
