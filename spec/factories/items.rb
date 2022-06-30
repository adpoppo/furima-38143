FactoryBot.define do
  factory :item do
    item_name { Faker::Lorem.word(max_length: 40) }
    item_description { Faker::Lorem.sentences(max_length: 1000) }
    category_id { Faker::Number.between(from: 1, to: 10) }
    condition_id { Faker::Number.between(from: 1, to: 6) }
    freight_id { Faker::Number.between(from: 1, to: 3) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    ship_day_id { Faker::Number.between(from: 1, to: 3) }
    price { Faker::Number.between(from: 300, to: 9999999) }
  end
end
