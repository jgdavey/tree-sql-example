class CategoriesController < ApplicationController
  expose(:categories) { Category.scoped }
  expose(:category)
  expose(:cat_pictures) { CatPicture.descendents_of(category).includes(:category) }
end
