module API
  module V1
    class ListsController < ApplicationController
      before_action :authenticate

      def index
        @lists = List.all
        render json: @lists.to_json, status: :ok
      end

      def create
        # binding.pry
        @list = @current_user.lists.new(list_params)

        if @list.save
          render json: @list.to_json, status: :created
        else
          render json: @list.errors.full_messages.to_json, status: :bad_request
        end
      end

      private

      def list_params
        params.require(:list).permit(:name, :permission)
      end



    end
  end
end