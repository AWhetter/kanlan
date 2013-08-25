class Seat < ActiveRecord::Base
  has_one :user
  belongs_to :table
end
