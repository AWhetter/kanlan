require 'spec_helper'

describe Row do
  describe "initialization" do
    it "cannot be created without a table" do
      row = FactoryGirl.build(:row, :table_count => 0)
      expect(row).to_not be_valid
    end

    it "can be created" do
      row = FactoryGirl.build(:row, :table_count => 1)
      expect(row).to be_valid
    end
  end
end
