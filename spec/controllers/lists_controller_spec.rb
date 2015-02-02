require 'rails_helper'

describe API::V1::ListsController do

  describe "show" do
    context "with correct user's token auth" do
      before do
        user = User.create!(email: 'karim@tarek.com', password: 'password')
        @request.env["HTTP_AUTHORIZATION"] = "Token token=#{user.authentication_token}"
      end

      it "can show any list belongs to user" do
        List.create!(name: 'my lovely list', user_id: 1)
        # list_params = { list: {id: 1} }
        get :show, :id => 1

        expect(response.status).to eq 200
      end

      it "can show any not private list belongs to another user" do
        user_2 = User.create(email: 'user@domain.com', password: 'password')
        list_private = user_2.lists.create!(name: 'new todo list_private', permission: 'private')
        list_viewable = user_2.lists.create!(name: 'new todo list_viewable', permission: 'viewable')
        list_public = user_2.lists.create!(name: 'new todo list_public', permission: 'public')

        get :show, :id => list_private.id
        expect(response.status).to eq 401
        expect(response.body).to include 'This list is private'

        get :show, :id => list_viewable.id
        expect(response.status).to eq 200
        expect(response.body).to include(list_viewable.name.to_json)

        get :show, :id => list_public.id
        expect(response.status).to eq 200
        expect(response.body).to include(list_public.name.to_json)
      end
    end

  end

  describe "destroy" do
    context "with correct user's token auth" do
      before do
        user = User.create!(email: 'karim@tarek.com', password: 'password')
        @request.env["HTTP_AUTHORIZATION"] = "Token token=#{user.authentication_token}"
      end
      it "can be deleted" do
        List.create!(name: 'my lovely list', user_id: 1)
        # update_params = {id: 1, list: { permission: 'private', user_id: 1}}
        delete :destroy, id: 1

        expect(response.status).to eq 200
      end
    end
  end

  describe "update" do
    context "with correct user's token auth" do
      before do
        user = User.create!(email: 'karim@tarek.com', password: 'password')
        @request.env["HTTP_AUTHORIZATION"] = "Token token=#{user.authentication_token}"
      end
      it "can change permission within allowed permissions" do
        List.create!(name: 'my lovely list', user_id: 1)
        update_params = {id: 1, list: { permission: 'private', user_id: 1}}
        put :update, update_params

        expect(response.status).to eq 200
      end

      it "can edit public lists that belongs to any user" do
        user_2 = User.create!(email: 'karim@gmail.com', password: 'password')
        list_public = user_2.lists.create!(name: 'new todo list_public', permission: 'public')
        update_params = {id: list_public.id, list: { permission: 'viewable'}}
        put :update, update_params

        expect(response.status).to eq 200
        expect(response.body).to include('viewable')
      end

      it "can't edit viewable lists belongs to other users" do
        user_2 = User.create!(email: 'karim@gmail.com', password: 'password')
        list_viewable = user_2.lists.create!(name: 'new todo list_viewable', permission: 'viewable')

        update_viewable = {id: list_viewable.id, list: { permission: 'public'}}
        put :update, update_viewable

        expect(response.status).to eq 401
        expect(response.body).to include("You don't have permission to edit this list")


      end
      it "can't edit private lists belongs to other users" do
        user_2 = User.create!(email: 'karim@gmail.com', password: 'password')
        list_private = user_2.lists.create!(name: 'new todo list_private', permission: 'private')

        update_private = {id: list_private.id, list: { permission: 'public'}}
        put :update, update_private

        expect(response.status).to eq 401
        expect(response.body).to include("You don't have permission to edit this list")
      end
    end

  end

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
        expect(response.body).to include(lists.to_json)
      end

      it "it doesn't return private lists" do
        user_2 = User.create!(email: 'karim@tarek.com', password: 'password')
        @request.env["HTTP_AUTHORIZATION"] = "Token token=#{user_2.authentication_token}"

        user = User.create!(email: 'karim@gmail.com', password: 'password')
        list_private = user.lists.create!(name: 'new todo list_private', permission: 'private')
        list_viewable = user.lists.create!(name: 'new todo list_viewable', permission: 'viewable')
        list_public = user.lists.create!(name: 'new todo list_public', permission: 'public')

        get :view_all

        expect(response.status).to eq 200
        expect(response.body).to eq([list_viewable, list_public].to_json)
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