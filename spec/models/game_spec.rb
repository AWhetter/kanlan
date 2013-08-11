require 'spec_helper'

describe Game do
  let (:game1) { FactoryGirl.build(:game, :name => "A game") }
  let (:game2) { FactoryGirl.build(:game, :name => "Be like Ruby") }

  it { should respond_to :name }
  it "should fail validation without a name" do
    game = FactoryGirl.build(:game, :name => nil)
    expect(game).to_not be_valid
  end

  it { should respond_to :url }
  context "with a url that doesn't begin with http or https" do
    it "should fail validation" do
      game = FactoryGirl.build(:game, :url => "test.host")
      expect(game).to_not be_valid
    end

    it "should allow the url if it does not exist" do
      game = FactoryGirl.build(:game, :url => nil)
      expect(game).to be_valid
    end
  end

  it { should respond_to :<=> }
  it "is sorted by it's name" do
    unsorted = [game2, game1]
    unsorted.sort_by! { |game| game.name }
    expect(unsorted).to match_array(unsorted.sort)
  end
end
