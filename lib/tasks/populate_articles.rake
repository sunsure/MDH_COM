namespace :db do
  require 'faker'
  desc "Populate the articles table with sample data"
  task :populate => [:environment] do
    100.times do |n|
      Article.create!(
        title: Faker::Lorem.sentence(1),
        excerpt: Faker::Lorem.paragraph,
        content: Faker::Lorem.paragraph,
        user_id: User.first.id,
        published_at: Time.zone.now
      )
    end
  end
end