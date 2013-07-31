require 'spec_helper'

describe Game do
  let (:game1) { FactoryGirl.build(:game, :name => "A game") }
  let (:game2) { FactoryGirl.build(:game, :name => "Be like Ruby") }

  it { should respond_to :name }
  it { should respond_to :url }

  it { should respond_to :<=> }
  it "is sorted by it's name" do
    unsorted = [game2, game1]
    unsorted.sort_by! { |game| game.name }
    expect(unsorted).to match_array(unsorted.sort)
  end
end
