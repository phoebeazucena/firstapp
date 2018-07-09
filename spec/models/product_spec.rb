require 'rails_helper'

describe Product do

  before do
    @product = FactoryBot.create(:product)
    @user = FactoryBot.create(:user)
    @product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
    @product.comments.create!(rating: 3, user: @user, body: "Ok bike!")
    @product.comments.create!(rating: 5, user: @user, body: "Great bike!")
  end

  context "when product has comments" do
    it "returns the average rating of all comments" do
      expect(@product.average_rating).to eq (3)
    end

    it "returns the highest rating of all comments" do
      expect(@product.highest_rating_comment).to eq (5)
    end

    it "returns the lowest rating of all comments" do
      expect(@product.lowest_rating_comment).to eq (1)
    end
  end

  context "when product is created" do

    it "is invalid without a name" do
      expect(Product.new(description: "Nice bike")).not_to be_valid
    end

    it "is valid with a name" do
      expect(Product.new(name: "race bike")).to be_valid
    end
  end

end
