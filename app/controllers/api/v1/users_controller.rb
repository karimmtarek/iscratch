module API
  module V1
    class UsersController < ApplicationController
      before_action :authenticate, only: [:destroy]

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
        if account_owner?(@user)
          @user.destroy
          render json: 'Message: User succsessfully deleted.', status: :ok
        else
          render json: "You don't have permission to delete this user.", status: :unauthorized
        end

      end

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