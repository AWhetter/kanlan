class PostsController < ApplicationController
  def all
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    user = User.find(session[:user_id])
    game = Game.find(params[:post][:game])
    @post = Post.where(:game_id => game.id).first

    if @post.nil?
      @post = Post.new(:game => game)
    else
      if @post.users.include? user
        redirect_to new_post_path, :notice => "You have already requested that game!"
        return
      end
    end

    @post.users << user
    if @post.save
      redirect_to root_url, :notice => "Successfully created post!"
    else
      redirect_to new_post_path, :notice => "Post not created!"
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

  def del_user
    respond_to do |format|
      if Post.find(params[:id]).users.delete(User.find(session[:user_id]))
        format.html { redirect_to root_url }
        format.js { render :nothing => true }
      else
        format.html { flash[:notice] = "Something went wrong!" }
        format.js
      end
    end
  end
end
