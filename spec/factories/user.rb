# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "ATestUser"
    ip "127.0.0.1"
    table "Kitty!"
    seat "A0"
  end
end
