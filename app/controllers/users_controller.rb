class UsersController < ApplicationController
  before_filter :get_tables

  def get_tables
    @tables = []
    @seats = []
    TABLES.each do |table|
      @tables << table["name"]
      table["rows"].each do |row|
        for j in 1..table["tables"]
          for i in 1..table["seats_per_table"]
            seat_name = row + ((j-1)*table["seats_per_table"] + (i-1)).to_s
            if !@seats.include? seat_name
              @seats << seat_name
            end
          end
        end
      end
    end
  end

  def new
    @user = User.new
    @user.ip = request.remote_ip
  end

  def create
    params[:user][:ip] = request.remote_ip
    @user = User.new(params[:user])

    if User.exists?(:ip => @user.ip)
      flash.now[:notice] = "You have already registered from this ip address"
      render "new"
    elsif !SEATS[params[:user][:table]].include?(params[:user][:seat])
      flash.now[:notice] = "Seat is not on selected table"
      render "edit"
    elsif @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Welcome, " + @user.username + "!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])

    if not SEATS[params[:user][:table]].include?(params[:user][:seat])
      flash.now[:notice] = "Seat is not on selected table"
      render "edit"
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Profile updated!"
    else
      render "edit"
    end
  end
end
