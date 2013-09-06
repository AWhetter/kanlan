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
    let(:new_post) do
      game = FactoryGirl.create(:game)
      FactoryGirl.attributes_for(:post, :game => game).merge(:game_id => game.id)
    end

    context "with an invalid new post" do
      let!(:old_count) do
        post_obj = Post.new(new_post)
        expect(post_obj.save).to be true
        expect(post_obj).to_not be_new_record

        Post.count
      end

      before do
        post :create, :post => new_post
      end

      it "does not create the post" do
        post_obj = Post.new(new_post)
        post_obj.save.should be false
        expect(Post.count).to eq(old_count)
      end

      it "redirects to creating a new post" do
        response.should redirect_to(new_post_path)
      end

      it "returns an error" do
        expect(flash[:error]).to_not be nil
      end

      it "gives a useful error message depending on the parameters given"
    end

    context "with a valid new post" do
      let!(:old_count) { Post.count }
      before do
        post :create, :post => new_post
      end

      it "creates the post" do
        post_obj = Post.new(new_post)
        expect(post_obj.save).to be false
        expect(Post.count).to eq(old_count + 1)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to(root_url)
      end

      it "returns a status message" do
        expect(flash[:notice]).to_not be nil
      end
    end
  end

  describe "add_user endpoint" do
    context "having invalid attributes" do
      it "does not add a user to a post"
      it "does not change the user"
    end

    context "having valid attributes" do
      context "and is already in the post" do
        it "does not raise an error"
        it "does not change the users"
      end

      context "and is not already in the post" do
        it "adds a user to the post"
      end
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
