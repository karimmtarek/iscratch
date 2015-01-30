require 'rails_helper'

describe 'Lists' do
  describe "create" do

    context "with correct user's password" do
      it "takes a list name and creates it if it doesn't exist" do
        list_params = {list: {name:'one new list'}}

        post "/v1/lists", list_params

        expect(response.status).to eq 201
        expect(List.first.name).to eq "one new list"

      end
      it "takes a list name and returns false if it exists" do
        List.create!(name:'one new list')

        list_params = {list: {name:'one new list'}}

        post "/v1/lists", list_params

        expect(response.status).to eq 400
      end
    end

    context "without correct user's password" do
      it "it errors"
    end
  end

  describe "index show list of lists" do
    context "with correct user's password" do
      it "returns all lists associated with the user" do
        list = List.create!(name: 'new list')
        lists = List.all

        get '/v1/lists'

        expect(response).to be_success
        expect(response.body).to include(lists.to_json)
      end
    end

    context "without correct user's password" do
      it "returns all visible and open lists"
    end

  end

end