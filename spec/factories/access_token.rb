FactoryGirl.define do
  factory :access_token do
    active true
  end

  # can be used when you want to test against expired access tokens:
  factory :inactive_access_token do
    active false
  end
end