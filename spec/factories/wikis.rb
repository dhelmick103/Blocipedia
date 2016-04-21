require "faker"

FactoryGirl.define do
  factory :wiki do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraphs.join("/n")
    private false
    user
  end
end
