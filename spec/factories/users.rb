require 'faker'

FactoryGirl.define do
  pw = Faker::Internet.password(8)
  factory :user do
    sequence(:username){|n| "user#{n}" }
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    confirmed_at Time.now
    role :standard
  end
end
