FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:5) }
    tool { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:50) }
  end
end