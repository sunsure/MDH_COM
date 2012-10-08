FactoryGirl.define do
  factory :role do |r|
    r.name { Faker::Name.first_name }
    r.key { Faker::Name.first_name.downcase }
  end
end
