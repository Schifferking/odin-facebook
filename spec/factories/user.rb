FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person#{n}@mail.com" }
    password { 'donotusethispassword' }
  end
end
