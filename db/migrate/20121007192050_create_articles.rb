class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.belongs_to :user
      t.datetime :published_at

      t.timestamps
    end
    add_index :articles, :user_id
  end
end
