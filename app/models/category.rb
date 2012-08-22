class Category < ActiveRecord::Base
  attr_accessible :name, :parent

  has_many :cat_pictures
  belongs_to :parent, :class_name => "Category"
  has_many :children, :class_name => "Category", :foreign_key => 'parent_id'

  scope :top_level, where(:parent_id => nil)

  def descendents
    self_and_descendents - [self]
  end

  def self_and_descendents
    self.class.tree_for(self)
  end

  def self.tree_for(instance)
    where(arel_table[:id].in(tree_sql_for(instance))).order(arel_table[:id])
  end

  def self.tree_sql_for(instance)
    tree      = Arel::Table.new(:search_tree)
    tree_id   = tree[:id]
    tree_path = tree[:path]

    base_term = where(:id => instance.id).select("#{table_name}.id, ARRAY[id]").arel
    recursive_term = tree.project(tree_id, "path || #{table_name}.id").from(tree).join(arel_table).on(arel_table[:parent_id].eq(tree_id)).where(Arel::SqlLiteral.new "NOT #{table_name}.id = ANY(path)")

    union = base_term.union(:all, recursive_term)

    as_statement = Arel::Nodes::As.new Arel::SqlLiteral.new("#{tree.name}(id, path)"), union

    arel_table.select_manager.with(:recursive, as_statement).from(tree).project tree_id
  end
end
