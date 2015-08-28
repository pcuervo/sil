require 'spec_helper'

describe Api::V1::ProjectsController do
  describe "GET #show" do
    before(:each) do
      @project = FactoryGirl.create :project
      get :show, id: @project.id
    end

    it "returns the information about project in JSON format" do
      project_response = json_response
      expect(project_response[:name]).to eql @project.name
      expect(project_response[:litobel_id]).to eql @project.litobel_id
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      5.times { FactoryGirl.create :project }
      get :index
    end

    it "returns 5 records from the database" do
      project_response = json_response
      expect(project_response[:projects].size).to eq(5)
    end
  end
end
