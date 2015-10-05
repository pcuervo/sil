require 'spec_helper'

describe Api::V1::ProjectsController do
  describe "GET #show" do
    before(:each) do
      @project = FactoryGirl.create :project
      get :show, id: @project.id
    end

    it "returns the information about project in JSON format" do
      project_response = json_response[:project]
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
      project_response = json_response[:projects]
      expect(project_response.size).to eq(5)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when project is succesfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        client = FactoryGirl.create :client
        @project_attributes = FactoryGirl.attributes_for :project
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, client_id: client.id,  project: @project_attributes }
      end

      it "renders the project record just created in JSON format" do
        project_response = json_response[:project]
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
      end

      it "renders an errors json" do 
        project_response = json_response
        expect(project_response).to have_key(:errors)
      end

      it "renders the json errors when there is no client present" do
        project_response = json_response
        expect(project_response[:errors][:client]).to include "not found"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    context "when project is successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        @project = FactoryGirl.create :project
        api_authorization_header @user.auth_token
        patch :update, { id: @project.id,
                          project: { litobel_id: 'hp_new_id', name: 'new_name' } }, format: :json
      end

      it "renders the json representation for the updated project" do
        project_response = json_response[:project]
        expect(project_response[:litobel_id]).to eql "hp_new_id"
        expect(project_response[:name]).to eql "new_name"
      end

      it { should respond_with 200 }
    end

    context "when is not updated because litobel_id is already taken" do
      before(:each) do
        @user = FactoryGirl.create :user
        @project = FactoryGirl.create :project
        @invalid_project = FactoryGirl.create :project
        api_authorization_header @user.auth_token
        patch :update, { id: @invalid_project.id,
                          project: { litobel_id: @project.litobel_id } }, format: :json
      end

      it "renders an errors json" do
        project_response = json_response
        expect(project_response).to have_key(:errors)
      end

      it "renders the json errors when the email is invalid" do
        user_response = json_response
        expect(user_response[:errors][:litobel_id]).to include "has already been taken"
      end
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

  describe "GET #get_project_users" do
    before(:each) do
      project = FactoryGirl.create :project

      3.times do
        user = FactoryGirl.create :user
        project.users << user
      end

      get :get_project_users, id: project.id
    end

    it "returns the users of the given project in JSON format" do
      project_users_response = json_response[:users]
      expect(project_users_response.size).to eq 3
    end

    it { should respond_with 200 }
  end

  describe "GET #get_project_client" do
    before(:each) do
      project = FactoryGirl.create :project
      @client = project.client
      client_contact = FactoryGirl.create :client_contact
      @client.client_contacts << client_contact

      get :get_project_client, id: project.id
    end

    it "returns the client and client_contact of the given project in JSON format" do
      project_client_response = json_response[:client]
      expect(project_client_response[:name]).to eq @client.name
    end

    it { should respond_with 200 }
  end

end
