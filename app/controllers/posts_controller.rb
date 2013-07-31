class PostsController < ApplicationController
  def index
    @posts = Post.all.sort
  end

  def new
  end

  def create
  end

  def add_user
  end

  def del_user
  end
end
