class CatPicture < ActiveRecord::Base
  attr_accessible :category, :name, :price

  belongs_to :category

  def self.descendents_of(category)
    joins("INNER JOIN (#{Category.tree_sql_for(category)}) tree ON #{table_name}.category_id = tree.id")
  end
end
