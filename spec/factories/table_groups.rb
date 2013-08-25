# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :table_group do
    name "TestTables"
    rows []
    left_end_table nil
    right_end_table nil

    ignore do
      row_count 1
    end

    after(:build) do |table_group,evaluator|
      for i in 0...evaluator.row_count
        table_group.rows << FactoryGirl.create(:row)
      end
    end
  end
end
