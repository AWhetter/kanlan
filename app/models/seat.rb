class Seat < ActiveRecord::Base
  has_one :user
  belongs_to :table

  def occupied? exclude_user
    return !self.user.nil? && self.user != exclude_user
  end
end
