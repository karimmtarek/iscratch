module API
  module V1
    class ListsController < ApplicationController
      before_action :authenticate

      def index
        @lists = @current_user.lists.all
        render json: @lists, status: :ok
      end

      def view_all
        @lists = List.view_all
        render json: @lists, status: :ok
      end

      def show
        @list = List.find(params[:id])
        if @list.other_users_private?(@current_user)
          render json: [Error: 'This list is private.'], status: :unauthorized
        else
          render json: @list, status: :ok
        end
      end

      def create
        @list = @current_user.lists.new(list_params)

        if @list.save
          render json: @list, status: :created
        else
          render json: "Error: #{@list.errors.full_messages}", status: :bad_request
        end
      end

      def update
        @list = List.find(params[:id])

        return render(json: "Error: You don't have permission to edit this list", status: :unauthorized) if @list.no_permission?(@current_user)

        if @list.update(list_params)
          render json: @list, status: :ok
        else
          render json: "Error: #{@list.errors.full_messages}", status: :bad_request
        end


      end

      def destroy
        @list = List.find(params[:id])

        return render json: "Error: You don't have permission to delete this list", status: :unauthorized if @list.no_permission?(@current_user)

        if @list.destroy
          render json: "List: #{@list.name}, is gone!", status: :ok
        else
          render json: "Error: #{@list.errors.full_messages}", status: :bad_request
        end

      end

      private

      def list_params
        params.require(:list).permit(:name, :permission)
      end

    end
  end
end