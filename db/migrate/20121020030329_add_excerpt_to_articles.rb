class AddExcerptToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :excerpt, :text
  end
end
