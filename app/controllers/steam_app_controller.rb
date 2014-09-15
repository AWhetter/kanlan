class SteamAppController < ApplicationController
	def suggest_local
		render json: SteamApp.where('name LIKE ?', "#{params[:q]}%").limit(10).map do |app|
			{id: app.id, name: app.name}
		end
	end

  def suggest
		json = JSON.parse(open("http://store.steampowered.com/search/suggest?term=#{params[:term]}&f=JSON&l=english&v=678581").read)[1]
		apps = []
		json.each do |name|
			app = SteamApp.find_by_name(name)
			apps << {id: app.id, name: name} if app
		end
		render json: apps
  end

	def show
		render json: SteamApp.select(:id, :name).find(params[:id])
	end
end
