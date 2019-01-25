FactoryBot.define do
  factory :reservation do
    start_date { Time.now }
    end_date { Time.now + 3.day }
    guest { FactoryBot.create(:user) }
    listing { FactoryBot.create(:listing) }
  end
end
