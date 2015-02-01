require 'rails_helper'

describe API::V1::ListsController do
  describe "create" do

    context "with correct user's token auth" do
      before do
        user = User.create!(email: 'karim@tarek.com', password: 'password')
        @request.env["HTTP_AUTHORIZATION"] = "Token token=#{user.authentication_token}"
      end

      it "takes a list name and creates it if it doesn't exist" do

        list_params = {list: {name:'one new list', user_id: 1}}


        post :create, list_params

        expect(response.status).to eq 201
        expect(List.first.name).to eq "one new list"

      end
      it "takes a list name and returns false if it exists" do
        List.create!(name:'one new list', user_id: 1)

        list_params = {list: {name:'one new list', user_id: 1}}

        post :create, list_params

        expect(response.status).to eq 400
      end
    end

    context "without correct user's token auth" do
      it "it returnes unauthorized error" do
        list_params = {list: {name:'one new list', user_id: 1}}

        post :create, list_params

        expect(response.status).to eq 401
      end
    end
  end

  describe "index show list of lists" do
    context "with correct user's token auth" do
      it "returns all lists associated with the user" do
        user = User.create!(email: 'karim@tarek.com', password: 'password')
        @request.env["HTTP_AUTHORIZATION"] = "Token token=#{user.authentication_token}"
        list = user.lists.create!(name: 'new list')
        lists = user.lists.all

        get :index

        expect(response.status).to eq 200
        expect(response.body).to include(list.to_json)
      end
    end

    context "without correct user's token auth" do
      it "returns unauthorized error" do
        get :index

        expect(response.status).to eq 401
      end
    end

  end

end