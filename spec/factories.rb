FactoryBot.define do
  sequence :email do |n|
    "someone#{n}@example.com"
  end

  factory :guest do
    email
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { ["0123456789"] }
  end

  factory :reservation do
    guest
    code { Faker::Code.asin }
    start_date { Faker::Date.forward(days: 5)}
    end_date { Faker::Date.forward(days: 10) }
    total_amount { 4000.00 }
    payout_amount { 3000.00 }
    currency { "AUD" }
    security_price { 500.00 }
    status { "accepted" }
    number_of_nights { 5 }
    number_of_adults { 2 }
    number_of_children { 2 }
    number_of_infants { 0 }
    number_of_guests { 4 }
  end
end
