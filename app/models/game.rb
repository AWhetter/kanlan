class Game < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :url, :with => URI::regexp(['http', 'https']), :allow_blank => true

  has_many :posts

  def <=>(other)
    self.name <=> other.name
  end
end
