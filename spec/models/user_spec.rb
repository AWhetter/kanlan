require 'spec_helper'

describe User do
  it { should respond_to :username }
  it "should fail validation without a username" do
    user = FactoryGirl.build(:user, :username => nil)
    expect(user).to_not be_valid
  end

  it "should fail validation without a unique username" do
    username = "NotUniqueUsername"
    seat = FactoryGirl.create(:seat)
    user = FactoryGirl.create(:user, :seat => seat, :username => username)

    seat = FactoryGirl.create(:seat)
    user = FactoryGirl.build(:user, :seat => seat, :username => username)
    expect(user).to_not be_valid
  end

  it { should respond_to :seat }
  it "should fail validation if the seat does not exist" do
    user = FactoryGirl.build(:user, :seat => nil)
    expect(user).to_not be_valid
  end

  it "should fail validation if the seat is occupied" do
    seat = FactoryGirl.create(:seat)
    FactoryGirl.create(:user, :seat => seat, :username => "AUser")
    user = FactoryGirl.build(:user, :seat => seat, :username => "BUser")
    expect(user).to_not be_valid
  end

  it "should not fail validation if the user is in the seat already" do
    seat = FactoryGirl.create(:seat)
    user = FactoryGirl.create(:user, :seat => seat)
    expect(user).to be_valid
  end

  it { should respond_to :== }
  describe "== method" do
    it "should return false when given any object other than a user" do
      user = FactoryGirl.build(:user)
      expect(user).to_not eq(Object.new)
    end

    it "should return false if the username is different" do
      user = FactoryGirl.build(:user, :username => "AUser")
      expect(FactoryGirl.build(:user, :username => "BeAUser")).to_not eq(user)
    end

    it "should return true if the username is the same" do
      user = FactoryGirl.build(:user, :ip => "127.0.0.1")
      expect(FactoryGirl.build(:user, :ip => "192.168.0.1")).to eq(user)
    end
  end
end
