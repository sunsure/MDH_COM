FactoryGirl.define do
  factory(:comment) do |comment|
    comment.content { Faker::Lorem.paragraph }
    comment.title { Faker::Lorem.sentence(1) }
    comment.association :article
    comment.association :user
  end
end
