require 'rails_helper'

describe 'user' do
  describe "something" do

    let(:user) { FactoryGirl.build(:user, password: 'password') }

    it "creates user with valid email/password" do
      expect(user.valid?).to eq(true)
    end

    it "doesn't create a user with invalid email" do
      inv_user = User.new(email: 'karim', password: 'pass')
      expect(inv_user.save).to be_falsy
    end

    it "doesn't create a user without a password" do
      inv_user = User.new(email: 'karim@gmail.com')
      expect(inv_user.save).to be_falsy
    end

    it "generates auth token when created" do
      user = User.create!(email: 'karim@gmail.com', password: 'password')
      expect(user.authentication_token.class).to eq(SecureRandom.hex.class)
    end
  end
end
