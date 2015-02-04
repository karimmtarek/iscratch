module API
  module V1
    class ItemsController < ApplicationController
      before_action :authenticate

      def index
        @items = Item.all
        render json: @items, status: :ok
      end

      def create
        @list = List.find(params[:list_id])
        @item = @list.items.new(item_params)

        if @item.save
          render json: "Item created: #{@list.items.to_json}", status: :created
        else
          render json: "Error: #{@item.errors.full_messages}", status: :bad_request
        end
      end

      def update
        @list = List.find(params[:list_id])
        @item = @list.items.find(params[:id])

        if @item.update(item_params)
          if @item.completed == true
            @item.destroy
            render json: 'Message: Item marked as completed and removed.', status: :ok
          else
            render json: 'Message: Item updated succssufully.', status: :ok
          end
        end

        # if params[:completed] != true || params[:completed] != false
        #   render json: "Error: #{@item.errors.full_messages}", status: :bad_request
        # end




      end

      def destroy
        @list = List.find(params[:list_id])
        @item = @list.items.find(params[:id])

        @item.destroy
        render json: 'Message: Item deleted succssufully.', status: :ok
      end

      private

      def item_params
        params.require(:item).permit(:name, :completed)
      end
    end
  end
end

