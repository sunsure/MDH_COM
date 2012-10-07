FactoryGirl.define do
  factory(:article) do |article|
    article.title { Faker::Lorem.sentence(1) }
    article.content { Faker::Lorem.paragraph }
    article.user_id { |i| i.association(:user) }
    article.published_at { Time.zone.now }
  end
end
