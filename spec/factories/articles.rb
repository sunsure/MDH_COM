FactoryGirl.define do
  factory(:article) do |article|
    article.title { Faker::Lorem.sentence(1) }
    article.excerpt { Faker::Lorem.paragraph }
    article.content { Faker::Lorem.paragraph }
    article.association :user
    article.published_at { Time.zone.now }
    article.sequence(:permalink) { |n| "#{Faker::Lorem.paragraph.split.sample}-#{n}".parameterize }
  end
end
