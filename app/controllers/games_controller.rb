class GamesController < ApplicationController
	before_filter :authenticate_user!

	def new
		@game = Game.new
	end

	def create
		@game = Game.new(game_params)
		save_and_redirect @game, 'Successfuly created game.', posts_new_path
	end

	private
	def game_params
		params[:game].permit(:name, :url, :steam_app_id)
	end
end
