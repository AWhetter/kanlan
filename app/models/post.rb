class Post < ActiveRecord::Base
  belongs_to :game
	has_and_belongs_to_many :users, -> { uniq }

	validates :game, presence: true
	validates :params, uniqueness: {scope: :game}

	def <=>(other)
		self.game <=> other.game
	end
end
