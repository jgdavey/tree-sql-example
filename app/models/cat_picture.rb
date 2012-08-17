class CatPicture < ActiveRecord::Base
  attr_accessible :category_id, :name, :price

  belongs_to :category
end
