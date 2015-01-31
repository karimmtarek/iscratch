require 'rails_helper'

describe 'User' do

  describe "create" do
    it "creates and returns a new user from email and password params" do
      user_params = { 'user' => { 'email' => 'testuser', 'password' => 'testpass' } }

      post "/v1/users", user_params

      expect(response.status).to eq 201

      # expect{ post :create, params }
      #   .to change{ User.all.count }
      #   .by 1

      # JSON.parse(response.body).should == User.last.authentication_token.to_json
    end

    it "returns an error when not given a password" do
      user_params = { 'user' => { 'email' => 'testuser' } }

      post "/v1/users", user_params

      expect(response.status).to eq 400
    end

    it "returns an error when not given an email" do
      user_params = { 'user' => { 'password' => 'testuser' } }
      post "/v1/users", user_params

      expect(response.status).to eq 400
    end
  end

  describe "index" do

    before do
      (1..3).each{ |n| User.create( id: n, username: "name#{n}", password: "pass#{n}" ) }
    end

    xit "lists all usernames and ids" do
      get :index

      JSON.parse(response.body).should ==
        { 'users' =>
          [
            { 'id' => 1, 'username' => 'name1' },
            { 'id' => 2, 'username' => 'name2' },
            { 'id' => 3, 'username' => 'name3' }
          ]
        }
    end
  end
end