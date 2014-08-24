class Post < ActiveRecord::Base
  belongs_to :game
	has_and_belongs_to_many :users, uniq: true

	validates :game, presence: true
	validates :params, presence: true, uniqueness: {scope: :game}

	def <=>(other)
		self.game <=> other.game
	end
end
