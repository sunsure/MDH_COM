require 'faker'

namespace :articles do
  desc "Populate Articles, Generate tags, Distribute Published On"
  task :all => [:populate, :generate_tags, :distribute]

  desc "Populate the articles table with sample data"
  task :populate => [:environment] do
    100.times do |n|
      Article.create!(
        title: Faker::Lorem.sentence(1),
        excerpt: Faker::Lorem.paragraph,
        content: Faker::Lorem.paragraph,
        user_id: User.first.id,
        published_at: Time.zone.now,
        permalink: "#{Faker::Lorem.paragraph.split.sample}-#{n}".parameterize
      )
    end
  end

  desc "Generate Random Tags for articles"
  task :generate_tags => [:environment] do
    puts "Generating tags..."
    input = %w[foo bar baz qux rails ruby]
    Article.find_each do |article|
      article.tag_list = input.sample( (1..(input.size)).to_a.sample).join(", ")
      article.save
    end
    puts "...done!"
  end

  desc "Distribute articles published at date over the last 5 months"
  task :distribute => [:environment] do
    Article.published.each do |k|
      new_published = rand(5.months.ago..Time.now)
      k.update_attribute(:published_at, new_published)
    end
  end

end
