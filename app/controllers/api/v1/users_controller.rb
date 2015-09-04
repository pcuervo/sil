class Api::V1::UsersController < ApplicationController
	include Loggable
	before_action :authenticate_with_token!, only: [:update, :create, :destroy]
	respond_to :json

	def index
		respond_with User.all
	end

	def show
		respond_with User.find(params[:id])
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: user, status: 201, location: [:api, user]
			log_action( current_user.id, 'Users', 'Created user "' + user.name + ' ' + user.last_name + ' with role ' + user.get_role , user.id )
			return
		end

		render json: { errors: user.errors }, status: 422
	end

	def update
		user = current_user

		if user.update(user_params)
			render json: user, status: 200, location: [:api, user]
		else
			render json: { errors: user.errors }, status: 422
		end
	end

	def destroy
	  current_user.destroy
	  head 204
	end

	private	

		def user_params
			params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :role)
		end
end
