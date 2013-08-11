FactoryGirl.define do
  factory :game do
    name "A game"
    url "http://example.com"
    initialize_with { Game.find_or_create_by(:name => name) }
  end
end
