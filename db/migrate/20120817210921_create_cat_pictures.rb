class CreateCatPictures < ActiveRecord::Migration
  def change
    create_table :cat_pictures do |t|
      t.string :name
      t.decimal :price
      t.integer :category_id

      t.timestamps
    end
  end
end
