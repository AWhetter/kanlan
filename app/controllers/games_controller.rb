class GamesController < ApplicationController
  def new
  end

  def create
    game = Game.new(game_params)
    if game.save
      flash[:notice] = "Created #{game.name}!"
      redirect_to new_post_path
    else
      flash[:error] = "Game not created!"
      redirect_to new_game_path
    end
  end

  private
  def game_params
    params.require(:game).permit(:name, :url)
  end
end
