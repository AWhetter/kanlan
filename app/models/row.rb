class Row < ActiveRecord::Base
  belongs_to :table_group
  has_many :tables

  validates_presence_of :tables
end
