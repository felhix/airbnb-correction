FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
    zip_code { "33800" }
  end
end
