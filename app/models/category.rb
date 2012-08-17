class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id

  has_many :cat_pictures
  belongs_to :parent, class_name: "Category"
end
