FactoryBot.define do
  factory :shift do
    name  { Faker::Name.name }
    start_time { "9:00am" }
    end_time { "12:00pm" }
    restaurant { create(:restaurant) }
  end
end
