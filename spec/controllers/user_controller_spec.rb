require 'rails_helper'

describe API::V1::UsersController do

  describe "create" do
    it "creates and returns a new user's token from valid email and password" do
      user_params = { user: { email: 'testuser@example.com', password: 'testpass' } }
      post :create, user_params
      expect(response.status).to eq 201
      expect(response.body).to include("Token: #{User.last.authentication_token}")
    end

    it "returns an error when not given a password" do
      user_params = { 'user' => { 'email' => 'testuser' } }
      post :create, user_params
      expect(response.status).to eq 400
      expect(response.body).to include("Password can't be blank")
    end

    it "returns an error when given an invalid email" do
      user_params = { 'user' => { 'email' => 'testuser', 'password' => 'testpass' } }
      post :create, user_params
      expect(response.status).to eq 400
      expect(response.body).to include('Email is invalid')
    end

    it "returns an error when not given an email" do
      user_params = { 'user' => { 'password' => 'testuser' } }
      post :create, user_params
      expect(response.status).to eq 400
      expect(response.body).to include("Email can't be blank")
    end
  end

  describe "delete" do
    before do
      @user = User.create!(email: 'karim@tarek.com', password: 'password')
      @request.env["HTTP_AUTHORIZATION"] = "Token token=#{@user.authentication_token}"
    end
    it "deletes own user's accont" do
      # user = User.create!(email: 'testuser@example.com', password: 'testpass')

      delete :destroy, id: @user.id

      expect(response.status).to eq 200
      expect(response.body).to include('User succsessfully deleted')
    end

    it "can't delete other user's accont" do
      user_2 = User.create(email: 'karim@gmail.com', password: 'password')

      delete :destroy, id: user_2.id
      expect(response.status).to eq 401
      expect(response.body).to include("You don't have permission to delete this user")
    end
  end

end