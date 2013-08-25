require 'spec_helper'

describe TableGroup do
  describe "initialization" do
    it "cannot be created without anything" do
      table_group = FactoryGirl.build(:table_group,
                                      :left_end_table => nil,
                                      :row_count => 0,
                                      :right_end_table => nil)
      expect(table_group).to_not be_valid
    end

    it "can be created with just a left end table" do
      table_group = FactoryGirl.build(:table_group,
                                      :left_end_table => FactoryGirl.create(:table),
                                      :row_count => 0,
                                      :right_end_table => nil)
      expect(table_group).to be_valid
    end

    it "can be created with just a row" do
      table_group = FactoryGirl.build(:table_group,
                                      :left_end_table => nil,
                                      :row_count => 1,
                                      :right_end_table => nil)
      expect(table_group).to be_valid
    end

    it "can be created with just a right end table" do
      table_group = FactoryGirl.build(:table_group,
                                      :left_end_table => nil,
                                      :row_count => 0,
                                      :right_end_table => FactoryGirl.create(:table))
      expect(table_group).to be_valid
    end
  end
end
