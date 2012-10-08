class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :key

      t.timestamps
    end
    add_index :roles, :key
  end
end
