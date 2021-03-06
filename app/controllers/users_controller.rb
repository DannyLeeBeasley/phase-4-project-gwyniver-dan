class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    wrap_parameters format: []

    def index
        users = User.all 
        render json: users, status: :ok 
    end

    def create 
        user = User.create(user_params)
        render json: user, status: :created
    end

    def update
        user = find_user
        user.update(user_params)
        render json: user, status: :accepted 
    end

    def destroy
        user = find_user
        user.destroy
        head :no_content
    end

    private

    def user_params
        params.permit(:name, :username, :email, :password_digest)
    end

    def find_user
        User.find(params[:id])
    end

    def render_not_found_response
        render json: { error: user.errors.full_messages }, status: :not_found 
    end
    
end
