FactoryBot.define do
  factory :table do
    name  { Faker::Name.name }
    restaurant { create(:restaurant) }
    min_guests 2
    max_guests 4
  end
end
