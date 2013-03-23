class UsersController < ApplicationController
  before_filter :get_tables

  def get_tables
    @tables = []
    @seats = []
    TABLES.each do |table|
      @tables << table["name"]

      extras = 0
      if END_TABLES[table["name"]].include? "L"
        extras += 1
      end
      if END_TABLES[table["name"]].include? "R"
        extras += 1
      end

      table["rows"].each do |row|
        for j in 1..table["tables"]
          for i in 1..table["seats_per_table"] + extras
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
    elsif !User.where(:table => params[:user][:table], :seat => params[:user][:seat]).empty?
      flash.now[:notice] = "Someone else is sat there!"
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

    if !SEATS[params[:user][:table]].include?(params[:user][:seat])
      flash.now[:notice] = "Seat is not on selected table"
      render "edit"
      return
    end

    users_in_seat = User.where(:table => params[:user][:table], :seat => params[:user][:seat])
    if !users_in_seat.empty? and users_in_seat != [@user]
      flash.now[:notice] = "Someone else is sat there!"
      render "edit"
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Profile updated!"
    else
      render "edit"
    end
  end
end
