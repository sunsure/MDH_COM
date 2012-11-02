FactoryGirl.define do
  factory(:article) do |article|
    article.title { Faker::Lorem.sentence(1) }
    article.excerpt { Faker::Lorem.paragraph }
    article.content { Faker::Lorem.paragraph }
    article.user_id { |i| i.association(:user) }
    article.published_at { Time.zone.now }
    article.permalink { Faker::Lorem.paragraph.split.sample.parameterize }
  end
end
