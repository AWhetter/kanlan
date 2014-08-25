class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	before_action :set_post, only: [:add_user, :rm_user]

  def index
		@posts = Post.all.sort
  end

  def new
		@post = Post.new
	end

  def create
		@post = Post.new(post_params)
		@post.users << current_user
		save_and_redirect 'Request was successfully posted.'
  end

  def add_user
		@post.users << current_user
		save_and_redirect 'Successfully added you to the request.'
  end

  def rm_user
		@post.users.delete current_user
		save_and_redirect 'Successfully removed you from the request.'
  end

	private
	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params[:post].permit(:game_id, :params)
	end

	def save_and_redirect(*args)
		super @post, *args
	end
end
