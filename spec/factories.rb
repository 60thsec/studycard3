FactoryGirl.define do
  factory :user do
    password "password"
    sequence(:username) { |n| Faker::Name.first_name + n.to_s }

    factory :invalid_user do
      username nil
    end
  end

  factory :deck do
    association :user
    sequence(:title) { |n| Faker::Lorem.word + n.to_s }
  end
end
