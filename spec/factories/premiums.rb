require 'faker'

FactoryGirl.define do
  pw = Faker::Internet.password(8)
  factory :premium do
    sequence(:username){|n| "user#{n}" }
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :premium
  end
end
