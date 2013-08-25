require 'spec_helper'

describe Seat do
  describe "initialization" do
    it "can be created" do
      seat = Seat.new
      expect(seat).to be_valid
    end
  end
end
