class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]

  respond_to :json

  def index
    respond_with Project.all
  end
  
  def show
    respond_with Project.find(params[:id])
  end

  def create
    project = current_user.projects.build(project_params)

    if project.save
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
    project_users = project.users(:id)

    users = []
    project_users.each do |pu| 
      user_obj = { :id => pu.id, :name => pu.first_name + ' ' + pu.last_name, :role => pu.role }
      users.push( user_obj )
    end

    render json: users, status: 200, location: [:api, project]
  end


  private

    def project_params
      params.require(:project).permit(:name, :litobel_id, :user_id)
    end
end
