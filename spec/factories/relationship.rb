FactoryBot.define do
  factory :relationship do
    sequence(:id) { |n| n }
    requester factory: :user
    requested factory: :user

    trait :pending do
      relationship_type { "pending" }
    end

    trait :friends do
      relationship_type { "friends" }
    end
  end

  factory :pending_relationship, traits: [:pending]
  factory :friends_relationship, traits: [:friends]
end
