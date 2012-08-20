class Category < ActiveRecord::Base
  attr_accessible :name, :parent

  has_many :cat_pictures
  belongs_to :parent, :class_name => "Category"
  has_many :children, :class_name => "Category", :foreign_key => 'parent_id'

  def descendents
    self_and_descendents - [self]
  end

  def self_and_descendents
    self.class.tree_for(self)
  end

  def self.tree_for(instance)
    find_by_sql <<-SQL
      WITH RECURSIVE search_tree(id, path) AS (
          SELECT id, ARRAY[id]
          FROM #{table_name}
          WHERE id = #{instance.id}
        UNION ALL
          SELECT #{table_name}.id, path || #{table_name}.id
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.parent_id=search_tree.id
          WHERE NOT #{table_name}.id = ANY(path)
      )
      SELECT * FROM #{table_name}
      WHERE id IN (SELECT id FROM search_tree);
    SQL
  end
end
