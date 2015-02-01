module API
  module V1
    class ListsController < ApplicationController
      before_action :authenticate

      def index
        @lists = List.all
        render json: @lists.to_json, status: :ok
      end

      def show
        @list = List.find(params[:id])
        render json: @list.to_json, status: :ok
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

      def update
        @list = List.find(params[:id])

        if @list.update(list_params)
          render json: @list.to_json, status: :ok
        else
          render json: @list.errors.full_messages.to_json, status: :bad_request
        end
      end

      def destroy
        @list = List.find(params[:id])

        if @list.destroy
          render json: "List: #{@list.name}, is gone!".to_json, status: :ok
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