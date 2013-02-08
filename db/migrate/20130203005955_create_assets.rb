class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :type
      t.string :attachment

      t.references :assetable, polymorphic: true

      t.timestamps
    end
  end
end
