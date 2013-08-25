class Table < ActiveRecord::Base
  belongs_to :row
  belongs_to :table_group
  has_many :seats

  validates_presence_of :seats
end
