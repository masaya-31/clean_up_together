FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:5) }
    tool { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:50) }
    member

    after(:build) do |post|
      post.after_image.attach(io: File.open('spec/images/after_image.jpg'), filename: 'after_image.jpg', content_type: 'application/xlsx')
    end
  end
end