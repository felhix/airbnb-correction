FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone_number { "0607080910" }
    description { Faker::Lorem.paragraph(25) }
  end
end
