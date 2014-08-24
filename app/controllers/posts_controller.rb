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
		save_and_render 'Request was successfully posted.'
  end

  def add_user
		@post.users << current_user
		save_and_render 'Successfully added you to the request.'
  end

  def rm_user
		@post.users.delete current_user
		save_and_render 'Successfully removed you from the request.'
  end

	private
	def set_post
		@post = Post.find(params[:id])
	end

	def save_and_render(success_msg='Success.')
		respond_to do |format|
			if @post.save
				format.html { redirect_to :index, notice: success_msg }
				format.json { render nothing: true, status: :created }
			else
				format.html { render :new }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end
end
