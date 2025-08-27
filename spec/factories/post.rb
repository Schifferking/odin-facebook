FactoryBot.define do
  factory :post do
    sequence(:id) { |n| n }
    title { "placeholder title" }
    body { "placeholder body" }
    user
  end
end