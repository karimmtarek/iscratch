module API
  module V1
    class ListsController < ApplicationController
      before_action :authenticate

      def index
        @lists = List.all
        respond_with(@lists)
      end

      # def new
      #   @list = List.new
      # end

      def create
        # binding.pry
        @list = List.new(list_params)

        if @list.save
          render text: @list.to_json, status: :created
        else
          render text: @list.errors.full_messages.to_json, status: :bad_request
        end
      end

      private

      def list_params
        params.require(:list).permit(:name, :permission)
      end

      def authenticate
        authenticate_or_request_with_http_token do |token, options|
          User.exists?(authentication_token: token)
        end
      end

    end
  end
end