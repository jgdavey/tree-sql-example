class CategoriesController < ApplicationController
  expose(:categories) { Category.scoped }
  expose(:category)
end
