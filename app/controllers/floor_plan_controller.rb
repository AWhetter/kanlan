class FloorPlanController < ApplicationController
  def show
    @tables = TABLES
    @longest_name = 0
    User.all.each do |user|
      if user.username.length > @longest_name
        @longest_name = user.username.length
      end
    end
  end
end
