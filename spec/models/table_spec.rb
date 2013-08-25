require 'spec_helper'

describe Table do
  describe "initialization" do
    it "cannot be created without a seat" do
      table = FactoryGirl.build(:table, :seat_count => 0)
      expect(table).to_not be_valid
    end

    it "can be created" do
      table = FactoryGirl.build(:table, :seat_count => 1)
      expect(table).to be_valid
    end
  end
end
