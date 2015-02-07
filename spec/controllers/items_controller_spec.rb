require 'rails_helper'

describe API::V1::ItemsController do
  # let(:user) { FactoryGirl.create(:user) }
  before do
    @user = User.create!(email: 'karim@tarek.com', password: 'password')
    @request.env["HTTP_AUTHORIZATION"] = "Token token=#{@user.authentication_token}"
  end

  describe "create" do
    it 'creates a new item' do
      list = @user.lists.create!(name: 'just another list')
      item_params = { item: {name:'one new item'}, list_id: list.id }
      post :create, item_params
      expect(response.status).to eq 201
      expect(response.body).to include('one new item')
    end
  end

  describe "index" do
    it 'gets all the items in a list' do
      list = @user.lists.create!(name: 'just another list')
      item = list.items.create!(name:'one new item')
      get :index, :list_id => list.id
      expect(response.status).to eq 200
      expect(response.body).to include(item.name)
    end
  end

  describe "update" do
    it "item if valid params" do
      list = @user.lists.create!(name: 'just another list')
      item = list.items.create!(name:'one new item')
      update_params = { id: item.id, list_id: list.id, item: { name: 'one true item'} }

      put :update, update_params

      expect(response.status).to eq 200
      expect(response.body).to include('Item updated succssufully')
    end

  end

  describe "destroy" do
    it "deletes an item if completed" do
      list = @user.lists.create!(name: 'just another list')
      item = list.items.create!(name:'one new item')
      delete :destroy, {id: item.id, list_id: list.id}

      expect(response.status).to eq 200
      expect(response.body).to include('Item deleted succssufully')
    end
  end

end