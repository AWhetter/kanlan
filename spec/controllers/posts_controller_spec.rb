require 'spec_helper'

describe PostsController do
  describe "index endpoint" do
    context "having no posts" do
      it "returns an empty list of posts"
    end

    context "having some posts" do
      it "returns the posts as a sorted list"
    end
  end

  describe "new endpoint" do
    it "returns success"
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
