FactoryGirl.define do
  factory :permission do |p|
    p.user { |i| i.association(:user) }
    p.role { |i| i.association(:role) }
  end
end
