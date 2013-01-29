class AddCommentsCountCacheToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :comments_count, :integer, default: 0

    Article.reset_column_information
    Article.find_each do |article|
      Article.update_counters article.id, comments_count: article.comments.length
    end
  end
end
