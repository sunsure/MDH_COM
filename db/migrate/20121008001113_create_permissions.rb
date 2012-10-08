class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.belongs_to :role
      t.belongs_to :user

      t.timestamps
    end
    add_index :permissions, :role_id
    add_index :permissions, :user_id
  end
end
