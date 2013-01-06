class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :article
      t.belongs_to :user
      t.string :ancestry
      t.text :content

      t.timestamps
    end
    add_index :comments, :article_id
    add_index :comments, :user_id
    add_index :comments, :ancestry
  end
end
