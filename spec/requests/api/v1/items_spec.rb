require 'rails_helper'

describe 'Item' do

  describe "create" do

    it 'iteam' do
      List.create!(name: 'just another list')
      item_params = {item: {name:'one new item', list_id: 1}}
      post '/v1/lists/1/items', item_params

      expect(response.status).to eq 201
      expect(response.body).to include("one new item")
    end

  end

end