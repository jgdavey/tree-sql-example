class Category < ActiveRecord::Base
  attr_accessible :name, :parent

  has_many :cat_pictures
  belongs_to :parent, :class_name => "Category"
  has_many :children, :class_name => "Category", :foreign_key => 'parent_id'

  def descendents
    self_and_descendents - [self]
  end

  def self_and_descendents
    [self] + children.map(&:self_and_descendents).flatten
  end
end
