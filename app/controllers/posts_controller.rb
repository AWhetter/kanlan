class PostsController < ApplicationController
  def all
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(:user => User.find(session[:user_id]))
    @post.assign_game params[:post][:game]

    if @post.save
      redirect_to root_url, :notice => "Successfully created post!"
    else
      flash[:notice] = "Post not created!"
      render action: "new"
    end
  end

  def destroy
    respond_to do |format|
      if Post.destroy(params[:id])
        format.html { redirect_to root_url }
        format.js { render :nothing => true }
      else
        format.html { flash[:notice] = "Something went wrong!" }
        format.js
      end
    end
  end
end
