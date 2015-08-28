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

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when project is succesfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @project_attributes = FactoryGirl.attributes_for :project
        api_authorization_header user.auth_token
        post :create, { user_id: user.id,  project: @project_attributes }
      end

      it "renders the project record just created in JSON format" do
        project_response = json_response
        expect(project_response[:name]).to eql @project_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when project is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_project_attributes = { name: "Proyecto Inválido" }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, project: @invalid_project_attributes }
        post :create, { user_id: user.id, project: @invalid_project_attributes }
      end

      it "renders an errors json" do 
        project_response = json_response
        expect(project_response).to have_key(:errors)
      end

      it "renders the json errors when litobel_id has already been taken" do
        project_response = json_response
        expect(project_response[:errors][:litobel_id]).to include "has already been taken"
      end

      it "renders the json errors when title has already been taken" do
        project_response = json_response
        expect(project_response[:errors][:name]).to include "has already been taken"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      user = FactoryGirl.create :user
      project = FactoryGirl.create :project
      api_authorization_header user.auth_token
      delete :destroy, { user_id: user.id, id: project.id }
    end

    it { should respond_with 204 }
  end
end
