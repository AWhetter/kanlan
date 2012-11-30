class PostsController < ApplicationController
  def all
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(:user => User.find(session[:user_id]), :game_id => params[:post][:game_id])

    if @post.save
      redirect_to root_url, :notice => "Successfully created post!"
    else
      flash[:notice] = "Post not created!"
      render action: "new"
    end
  end

  def destroy
    if Post.destroy(params[:id])
      redirect_to root_url
    else
      flash[:notice] = "Something went wrong!"
    end
  end
end
