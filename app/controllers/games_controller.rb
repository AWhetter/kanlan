class GamesController < InheritedResources::Base
	before_filter :authenticate_admin!, only: [:edit, :update, :destroy]
	before_filter :authenticate_user!, only: [:new, :create]

	private
	def permitted_params
		params.permit(game: [:name, :url, :steam_app_id])
	end
end
