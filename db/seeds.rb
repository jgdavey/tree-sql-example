def create_category(name, parent, subcategories)
  cat = Category.create(:name => name, :parent => parent)
  subcategories.each do |key, sub|
    create_category(key, cat, sub)
  end
end

{
  "Cat Pictures" => {
    "Funny" => {
      "LOLCats" => {},
      "Animated" => {}
    },
    "Classic" => {
      "Renaissance" => {}
    }
  }
}.each do |name, sub|
  create_category(name, nil, sub)
end
