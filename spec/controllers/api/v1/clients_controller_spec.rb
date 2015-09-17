require 'spec_helper'

describe Api::V1::ClientsController do
  describe "GET #show" do 
    before(:each) do
      @client = FactoryGirl.create :client
      get :show, id: @client.id
    end

    it "returns the information about a client in JSON format" do
      client_response = json_response
      expect(client_response[:name]).to eql @client.name
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      5.times { FactoryGirl.create :client }
      get :index
    end

    it "it should return 5 clients from database" do
      clients_response = json_response
      expect(clients_response[:clients].size).to eq(5)
    end

    it { should respond_with 200 }
  end
end
