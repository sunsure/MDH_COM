FactoryGirl.define do
  factory(:comment) do |comment|
    comment.content { Faker::Lorem.paragraph }
    comment.association :article
  end
end
