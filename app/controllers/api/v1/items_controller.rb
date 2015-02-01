module API
  module V1
    class ItemsController < ApplicationController
      before_action :authenticate

      def index
        @items = Item.all
        render json: @items.to_json, status: :ok
      end

      # def new
      #   @item = List.find(params[:list_id]).items.new
      # end

      def create
        @list = List.find(params[:list_id])
        @item = @list.items.new(item_params)

        if @item.save
          render text: @list.items.to_json, status: :created
        else
          render text: @item.errors.full_messages.to_json, status: :bad_request
        end
      end

      private

      def item_params
        params.require(:item).permit(:name, :completed)
      end
    end
  end
end

