# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :oracle do
    email Forgery(:email).address
  end
end
