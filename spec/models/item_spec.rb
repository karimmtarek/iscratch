require 'rails_helper'

describe 'Item' do
  let(:item) { FactoryGirl.create(:item) }

  it "a new one can be created, with valid params" do
    # item = Item.new(name: 'name', completed: false)
    item.save
    expect(item.save).to eq true
    expect(Item.all.size).to eq(1)
  end

  it "completed is false when created" do
    item.save
    expect(item.completed).to be_falsy
  end

  it "can't be created, with invalid params" do
    inv_item = Item.new
    inv_item.save
    expect(Item.all.size).to eq(0)
  end

  it "can be deleted" do
    item.save
    expect(Item.all.size).to eq(1)

    item.destroy
    expect(Item.all.size).to eq(0)
  end

  it "can be updated with valid params" do
    item.save
    item.name = 'new item name'
    item.save
    expect(item.name).to eq('new item name')
  end

  it "can't be updated with invalid params" do
    item.save
    item.name = ''

    expect(item.save).to be_falsy
  end

  it "returns completed true when set to true" do
    item = Item.new(name: 'name', completed: true)
    expect(item.completed).to eq(true)
  end

  it "completed is false if not set" do
    item = Item.create!(name: 'name')
    expect(item.completed).to eq(false)
  end
end