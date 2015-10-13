class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]

  respond_to :json

  def index
    respond_with Project.order(created_at: :desc).all
  end
  
  def show
    respond_with Project.find(params[:id])
  end

  def create
    client = Client.find_by_id(params[:client_id])
    pm = User.find(params[:pm_id])
    ae = User.find(params[:ae_id])

    if client.nil? 
      errors = { :client => "not found" }
      render json: { errors: errors }, status: 422
      return
    end

    #project = current_user.projects.build(project_params)
    project = Project.new(project_params)
    project.client = client

    if project.save
      AccountExecutiveProject.create(:user_id => ae.id, :project_id => project.id)
      ManagerProject.create(:user_id => pm.id, :project_id => project.id)
      render json: project, status: 201, location: [:api, project]
      return
    end

    render json: { errors: project.errors }, status: 422
  end

  def update
    project = Project.find(params[:id])

    if project.update(project_params)
      render json: project, status: 200, location: [:api, project]
      return
    end

    render json: { errors: project.errors }, status: 422
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    head 204
  end 

  def get_project_users
    project = Project.find( params[:id] )
    project_users = project.users

    users = []
    project_users.each do |pu| 
      user_obj = { :id => pu.id, :name => pu.first_name + ' ' + pu.last_name, :role => pu.role }
      users.push( user_obj )
    end

    render json: { :users => users }, status: 200, location: [:api, project]
  end

  def get_project_client
    project = Project.find( params[:id] )
    client = project.client
    client_contact = client.client_contacts.first


    client_obj = { :id => client.id, :name => client.name, :contact_name => client_contact.first_name + ' ' + client_contact.last_name }
    render json: { :client => client_obj }, status: 200, location: [:api, project]
  end


  private

    def project_params
      params.require(:project).permit(:name, :litobel_id, :user_id)
    end
end
