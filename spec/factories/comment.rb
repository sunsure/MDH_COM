FactoryGirl.define do
  factory(:comment) do |comment|
    comment.content { Faker::Lorem.paragraph }
  end
end
