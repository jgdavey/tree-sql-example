require 'spec_helper'

describe Category do
  describe "#descendents" do
    after(:all) { Category.delete_all }
    let(:grandpa) { Category.create(:name => "Grandpa") }

    it "includes immediate children" do
      bob = Category.create(:name => "Uncle Bob", :parent => grandpa)
      susie = Category.create(:name => "Aunt Susie", :parent => grandpa)

      grandpa.descendents.should == [bob, susie]
    end

    it "includes both children and grandchildren" do
      bob = Category.create(:name => "Uncle Bob", :parent => grandpa)
      carol = Category.create(:name => "Carol", :parent => bob)

      grandpa.descendents.should == [bob, carol]
    end

    it "includes all great-grandchildren" do
      bob = Category.create(:name => "Uncle Bob", :parent => grandpa)
      carol = Category.create(:name => "Carol", :parent => bob)
      dave = Category.create(:name => "Dave", :parent => carol)

      grandpa.descendents.should == [bob, carol, dave]
    end
  end
end
