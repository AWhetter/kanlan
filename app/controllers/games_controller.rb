class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    if session[:user_id]
      params[:game][:user] = User.find(session[:user_id])
      @game = Game.new(params[:game])
      if @game.save
        redirect_to root_url, :notice => "Created " + @game.name
      else
        render action: "new"
      end
    else
      flash[:notice] = "Must be logged in!"
      render action: "new"
    end
  end
end
