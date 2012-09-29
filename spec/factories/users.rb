FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "foo#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
