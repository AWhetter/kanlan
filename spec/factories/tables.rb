# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :table do
    seats []

    ignore do
      seat_count 1
    end

    after(:build) do |table, evaluator|
      for i in 0...evaluator.seat_count
        table.seats << FactoryGirl.create(:seat, :name => "A#{i}")
      end
    end
  end
end
