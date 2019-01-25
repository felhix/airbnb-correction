FactoryBot.define do
  factory :listing do
    available_beds { rand(1..5) }
    price { rand(10..100) }
    description { Faker::Lorem.paragraph(15) }
    has_wifi { Faker::Boolean.boolean }
    welcome_message { "Bienvenue dans ma super maison ! Pour y accéder il faut tourner la bobinette et la chevillette cherra" }
    city { FactoryBot.create(:city) }
    admin { FactoryBot.create(:user) }
  end
end
