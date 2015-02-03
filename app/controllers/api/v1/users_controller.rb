module API
  module V1
    class UsersController < ApplicationController
      before_action :authenticate, only: [:destroy]

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
          render json: "Token: #{@user.authentication_token}", status: :created
        else
          render json: "Error: #{@user.errors.full_messages}", status: :bad_request
        end
      end

      def destroy
        @user = @current_user
        # binding.pry
        if account_owner?(@user)
          @user.destroy
          render json: 'Message: User succsessfully deleted.', status: :ok
        else
          render json: "You don't have permission to delete this user.", status: :unauthorized
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

      def account_owner?(user)
        params[:id].to_i == user.id
      end
    end
  end
end