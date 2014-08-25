class FloorPlanController < ApplicationController
  def show
		@tables = KanLan::TABLES
  end
end
