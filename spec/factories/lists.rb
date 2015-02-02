FactoryGirl.define do
  factory :list do
    name "Shopping List"
    user_id 1
    # permission "private"
  end

  factory :list_public do
    name "Public List"
    user_id 2
    permission "public"
  end

  factory :list_viewable do
    name "Viewable List"
    user_id 2
    permission "viewable"
  end

  factory :list_private do
    name "Private List"
    user_id 2
    permission "private"
  end
end