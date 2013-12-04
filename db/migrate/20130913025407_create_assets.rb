class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :asset
      t.references :post

      t.timestamps
    end

    remove_column :posts, :asset
  end
end
