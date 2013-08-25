# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :row do
    tables []

    ignore do
      table_count 1
    end

    after(:build) do |row,evaluator|
      for i in 0...evaluator.table_count
        row.tables << FactoryGirl.create(:table)
      end
    end
  end
end
