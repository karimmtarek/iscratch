require 'rails_helper'

describe 'List' do

  let(:user) { FactoryGirl.create(:user) }
  let(:list) { user.lists.create(name: 'new todo list') }

  it "a new one can be created, with valid params" do
    list.save
    expect(List.all.size).to eq(1)
  end

  it "can't be created if list name exists" do
    list2 = user.lists.new(name: list.name)
    expect(list2.valid?).to be_falsy
  end

  it "can't be created, with invalid params" do
    inv_list = user.lists.new
    expect(inv_list.save).to be_falsy
  end

  it "can be deleted" do
    list.save
    expect(user.lists.all.size).to eq(1)

    list.destroy
    expect(List.all.size).to eq(0)
  end

  it "can be updated with valid params" do
    list.save
    list.name = 'new list name'
    list.save
    expect(list.name).to eq('new list name')
  end

  it "can't be updated with invalid params" do
    list.save
    list.name = ''

    expect(list.save).to be_falsy
  end

  it "can change permission within allowed permissions" do
    list.permission = 'private'
    expect(list.save).to eq true

    list.permission = 'viewable'
    expect(list.save).to eq true

    list.permission = 'public'
    expect(list.save).to eq true
  end

  it "can't change permission with out allowed permissions" do
    list.permission = 'open'
    expect(list.save).to be_falsy
  end

  it "returns permission when available" do
    list = List.new(name: 'name', permission: 'private')
    expect(list.permission).to eq('private')
  end

  it "it has a permission of 'public' if not available" do
    list = List.new(name: 'name')
    expect(list.permission).to eq('public')
  end

end