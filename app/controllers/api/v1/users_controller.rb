module API
  module V1
    class UsersController < ApplicationController
      # before_action :require_signin, except: [:new, :create]
      # before_action :require_correct_user, only: [:edit, :update, :destroy]

      # def index
      #   redirect_to user_path(current_user)
      # end

      # def show
      #   @user = User.find(params[:id])
      # end

      # def new
      #   @user = User.new
      # end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user.authentication_token.to_json, status: :created
        else
          render json: @user.errors.full_messages.to_json, status: :bad_request
        end
      end

      # def edit
      #   @user = User.find(params[:id])
      # end

      # def update
      #   @user = User.find(params[:id])
      #   if @user.update(user_params)
      #     redirect_to dashboard_path
      #   else
      #     render :edit
      #   end
      # end

    private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end