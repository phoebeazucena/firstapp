require 'rails_helper'

  describe Comment do
    before do
      @product = FactoryBot.create(:product)
      @user = FactoryBot.create(:user)
      @product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
    end

    context "when a comment is created" do

      it "has a body" do
        expect(Comment.new(rating: 1, user: @user, body: "Awful bike!", product: @product)).to be_valid
        expect(Comment.new(rating: 1, user: @user, body:nil, product: @product)).not_to be_valid
      end

      it "has a user" do
        expect(Comment.new(rating: 1, user: @user, body: "Awful bike!", product: @product)).to be_valid
        expect(Comment.new(rating: 1, user:nil , body:"Awful bike!", product: @product)).not_to be_valid
      end

      it "has a numerical rating" do
        expect(Comment.new(rating: 1, user: @user, body: "Awful bike!", product: @product)).to be_valid
        expect(Comment.new(rating: "x", user: @user , body:"Awful bike!", product: @product)).not_to be_valid
      end

      it "has a product" do
        expect(Comment.new(rating: 1, user: @user, body: "Awful bike!", product: @product)).to be_valid
        expect(Comment.new(rating:1, user: @user , body:"Awful bike!", product:nil)).not_to be_valid
      end
    end
  end
