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

categories = Category.all

[
  "Turkleton's Folly",
  "A Night Without Milk",
  "Till Death",
  "Triple LOL",
  "Feeble Disposition",
  "LOLlipop",
  "Where's the Beef?",
].each do |name|
  CatPicture.create(:name => name, category: categories.sample)
end
