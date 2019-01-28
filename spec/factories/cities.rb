FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
    sequence(:zip_code) { |n| (90000 - n).to_s  }
  end
end
