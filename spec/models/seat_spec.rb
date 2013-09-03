require 'spec_helper'

describe Seat do
  describe "initialization" do
    it "can be created" do
      seat = Seat.new
      expect(seat).to be_valid
    end
  end

  describe "occupied method" do
    it "returns false if the seat is empty" do
      seat = FactoryGirl.create(:seat, :user => nil)

      expect(seat.occupied?(Object.new)).to be false
    end

    it "returns false if the seat is occupied by the given user" do
      seat = FactoryGirl.create(:seat)
      user = FactoryGirl.build(:user)
      user.seat = seat
      user.save

      expect(seat.occupied?(user)).to be false
    end

    it "returns true if the seat is occupied" do
      seat = FactoryGirl.create(:seat, :name => "A0")
      in_seat_user = FactoryGirl.build(:user, :username => "AUser")
      in_seat_user.seat = seat
      in_seat_user.save

      test_user = FactoryGirl.build(:user, :username => "BUser")

      expect(seat.occupied?(test_user)).to be true
    end
  end
end
