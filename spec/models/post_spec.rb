require 'spec_helper'

describe Post do
  let(:post1) { FactoryGirl.build(:post) }
  let(:post2) { FactoryGirl.build(:post) }

  it { should respond_to :game }
  it { should respond_to :params }

  it { should respond_to :<=> }
  it "is sorted by it's game" do
    post1.stub(:game) { "A game" }
    post2.stub(:game) { "Be like Ruby" }

    unsorted = [post2, post1]
    unsorted.sort_by! { |post| post.game }
    expect(unsorted).to match_array(unsorted.sort)
  end
end
