class CatPicture < ActiveRecord::Base
  attr_accessible :category, :name, :price

  belongs_to :category

  def self.descendents_of(category)
    where("#{table_name}.category_id IN (#{Category.tree_sql_for(category)})")
  end
end
