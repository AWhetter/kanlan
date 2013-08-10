class PostsController < ApplicationController
  def index
    @posts = Post.all.sort
  end

  def new
  end

  def create
    if Post.new(post_params).save
      flash[:notice] = "Successfully created post!"
      redirect_to root_url
    else
      flash[:error] = "Post not created!"
      redirect_to new_post_path
    end
  end

  def add_user
  end

  def del_user
  end

  private
  def post_params
    params.require(:post).permit(:game_id, :params)
  end
end
