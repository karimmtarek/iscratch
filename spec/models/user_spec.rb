require 'rails_helper'

describe 'user' do
  describe "something" do

    let(:user) { FactoryGirl.build(:user, password: 'password') }

    xit "something" do
      user.authenticate?('password').should be_true
      user.authenticate?('otherpass').should be_false
    end
  end
end
