require 'spec_helper'

describe PostsController do
  describe "index endpoint" do
    context "with no posts" do
      it "puts an empty list of posts into @posts" do
        get :index
        expect(assigns(:posts)).to be_empty
      end
    end

    context "with some posts" do
      before do
        game = FactoryGirl.create(:game, :name => "Be like Ruby")
        FactoryGirl.create(:post, :game => game)
        game = FactoryGirl.create(:game, :name => "A game")
        FactoryGirl.create(:post, :game => game)
      end

      it "puts a list of posts into @posts sorted by game name" do
        get :index
        expect(assigns(:posts)).to match_array(Post.all.sort)
      end
    end
  end

  describe "new endpoint" do
    it "returns success" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "create endpoint" do
    it "creates a new post"
    it "does not create a new post if a similar one already exists"
  end

  describe "add_user endpoint" do
    context "having invalid attributes" do
      it "does not add a user to a post"
      it "does not change the user"
    end

    context "having valid attributes" do
      it "adds a user to the post"
    end
  end

  describe "del_user endpoint" do
    context "having invalid attributes" do
      it "does not delete a user from a post"
      it "does not change the user"
    end

    context "having valid attributes" do
      it "deletes a user from the post"
    end
  end
end
