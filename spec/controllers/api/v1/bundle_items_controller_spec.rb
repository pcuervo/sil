require 'spec_helper'

describe Api::V1::BundleItemsController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @bundle_item = FactoryGirl.create :bundle_item
      @part = FactoryGirl.create :bundle_item_part
      @another_part = FactoryGirl.create :bundle_item_part
      @bundle_item.bundle_item_parts << @part
      @bundle_item.bundle_item_parts << @another_part
      @bundle_item.update_num_parts

      get :show, id: @bundle_item.id
    end

    it "returns the information about a bundle_item in JSON format" do
      bundle_item_response = json_response[:bundle_item]
      expect(bundle_item_response[:num_parts]).to eql 2
      expect(bundle_item_response[:is_complete]).to eql true
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

  describe "GET #index" do
    before(:each) do
      3.times{ FactoryGirl.create :bundle_item }
      get :index
    end

    it "returns 5 unit items from the database" do
      bundle_items_response = json_response
      expect(bundle_items_response[:bundle_items].size).to eq(3)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is succesfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        project = FactoryGirl.create :project

        @bundle_item_attributes = FactoryGirl.attributes_for :bundle_item
        @bundle_item_attributes[:project_id] = project.id
        @part_attributes = FactoryGirl.attributes_for :bundle_item_part
        @another_part_attributes = FactoryGirl.attributes_for :bundle_item_part

        parts = [ @part_attributes, @another_part_attributes ]

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, bundle_item: @bundle_item_attributes, :entry_date => Time.now, :storage_type => 'Permanente', :delivery_company => 'DHL', :parts => parts }
      end

      it "renders the json representation for the inventory item just created" do
        bundle_item_response = json_response[:bundle_item]
        expect(bundle_item_response[:name]).to eql @bundle_item_attributes[:name]
      end

      it "should record the transaction in database" do
        bundle_item_response = json_response[:bundle_item]
        inv_item = InventoryItem.find_by_actable_id(bundle_item_response[:id])
        inv_transaction = InventoryTransaction.find_by_inventory_item_id(inv_item.id)
        expect(inv_transaction.to_json.size).to be >= 1
      end

      it "should have the updated number of parts" do 
        bundle_item_response = json_response[:bundle_item]
        expect(bundle_item_response[:num_parts]).to eql 2
      end

      it { should respond_with 201 }
    end

    context "when is not created because of BundleItem data" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_bundle_item_attributes = { user_id: user.id }
        part = FactoryGirl.attributes_for :bundle_item_part
        parts_arr = [ part ]

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, bundle_item: @invalid_bundle_item_attributes, parts: parts_arr }
      end

      it "renders an errors json" do
        bundle_item_response = json_response
        expect(bundle_item_response).to have_key(:errors)
      end

      it "renders the json errors on why the inventory item could not be created" do
        bundle_item_response = json_response

        expect(bundle_item_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }

    end

    context "when is not created because there are no BundleItemParts" do
      before(:each) do
        user = FactoryGirl.create :user
        project = FactoryGirl.create :project

        @bundle_item_attributes = FactoryGirl.attributes_for :bundle_item
        @bundle_item_attributes[:project_id] = project.id
        parts = [ ]

        api_authorization_header user.auth_token
        post :create, { user_id: user.id, bundle_item: @bundle_item_attributes, :entry_date => Time.now, :storage_type => 'Permanente', :delivery_company => 'DHL', :parts => parts }
      end

      it "renders an errors json" do
        bundle_item_response = json_response
        expect(bundle_item_response).to have_key(:errors)
      end

      it "renders the json errors on why the inventory item could not be created" do
        bundle_item_response = json_response
        expect(bundle_item_response[:errors][:parts]).to include "cannot be empty"
      end

      it { should respond_with 422 }

    end
  end

end


