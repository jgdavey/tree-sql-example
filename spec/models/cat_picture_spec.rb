require 'spec_helper'

describe CatPicture do
  describe "#descendent_pictures" do
    after { Category.delete_all; CatPicture.delete_all }

    it "includes immediate children's cat pictures" do
      grandpa = Category.create(:name => "Grandpa")
      grandpa_cat = CatPicture.create(:category => grandpa, :name => "Grandpa's Cat Picture")

      bob = Category.create(:name => "Uncle Bob", :parent => grandpa)
      bob_cat = CatPicture.create(:category => bob, :name => "Bob's Cat Picture")

      susie = Category.create(:name => "Aunt Susie", :parent => grandpa)
      susie_cat = CatPicture.create(:category => susie, :name => "Susie's Cat Picture")

      outlier = CatPicture.create(:name => "Not in the list")

      CatPicture.descendents_of(grandpa).should == [grandpa_cat, bob_cat, susie_cat]
    end
  end
end
