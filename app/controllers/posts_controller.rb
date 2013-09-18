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
    begin
      user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      reset_session
      flash[:error] = "Invalid user logged in!"
      redirect_to root_url
      return
    end

    begin
      post = Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Invalid post!"
      return
    end

    post.add_user user
    if post.save
      flash[:notice] = "Added user to the post!"
    else
      flash[:error] = "User was not added to post!"
    end
  end

  def del_user
    begin
      user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      reset_session
      flash[:error] = "Invalid user logged in!"
      redirect_to root_url
      return
    end

    begin
      post = Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Invalid post!"
      return
    end

    post.del_user user
    if post.save
      flash[:notice] = "Removed user from the post!"
    else
      flash[:error] = "User was not removed from the post!"
    end
  end

  private
  def post_params
    params.require(:post).permit(:game_id, :params)
  end
end
