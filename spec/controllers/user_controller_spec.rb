require 'rails_helper'

describe API::V1::UsersController do

  describe "create" do
    it "creates and returns a new user from valid email and password" do
      user_params = { 'user' => { 'email' => 'testuser@example.com', 'password' => 'testpass' } }
      post :create, user_params
      expect(response.status).to eq 201
      expect(response.body).to include(User.last.authentication_token)
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

end