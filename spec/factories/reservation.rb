FactoryBot.define do
  factory :reservation do
    guest
    shift
    table { create(:table, restaurant: shift.restaurant) }
    time  { "10:00am" }
    guests_count { 2 }
  end
end
