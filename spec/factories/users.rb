FactoryGirl.define do

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "foo#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
  factory :user_with_roles, parent: :user do
    ignore do
      with_roles []
    end

    after(:build) do |user, evaluator|
      evaluator.with_roles.each do |role|
        roll = FactoryGirl.create(:role, name: role, key: role) # it's a play on words!
        user.permissions.build(role: roll, user: user)
      end
    end
  end

end
