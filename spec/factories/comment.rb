FactoryGirl.define do
  factory(:comment) do |comment|
    comment.content { Faker::Lorem.paragraph }
    comment.article { FactoryGirl.create(:article) }
  end
end
