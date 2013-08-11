require 'spec_helper'

describe Post do
  let(:post1) { FactoryGirl.build(:post) }
  let(:post2) { FactoryGirl.build(:post) }

  it { should respond_to :game }
  it "should fail validation without a game" do
    post =  FactoryGirl.build(:post, :game => nil)
    expect(post).to_not be_valid
  end

  it { should respond_to :params }
  context "with the same game" do
    before { post1.save }

    context "and same params" do
      it "should fail validation" do
        expect(post1.dup).to be_invalid
      end
    end

    context "but different params" do
      it "should pass validation" do
        new_post = post1.dup
        new_post.params = "#{post1.params} extra"
        expect(new_post).to be_valid
      end
    end
  end

  it { should respond_to :<=> }
  it "is sorted by it's game" do
    post1.stub(:game) { "A game" }
    post2.stub(:game) { "Be like Ruby" }

    unsorted = [post2, post1]
    unsorted.sort_by! { |post| post.game }
    expect(unsorted).to match_array(unsorted.sort)
  end
end
