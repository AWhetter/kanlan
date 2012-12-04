class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    if session[:user_id]
      if Game.find_by_name(params[:game][:name]) != nil
        flash.now[:notice] = "Game already exists!"
        render action: "new"
      else
        @game = Game.new(params[:game])

        if @game.url? and !@game.url.start_with?("http")
          @game.url = "http://" + @game.url
        end

        if @game.save
          redirect_to posts_new_url :notice => "Created " + @game.name
        else
          render action: "new"
        end
      end
    else
      flash.now[:notice] = "Must be registered!"
      render action: "new"
    end
  end

  def all
    @games = Game.all.sort { |a,b| a.name <=> b.name }
  end
end
