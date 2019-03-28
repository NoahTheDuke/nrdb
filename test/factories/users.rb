FactoryBot.define do
  factory :user do
    username { Faker::Name.name[0...20] }
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password { 'password1234' }
    password_confirmation { 'password1234' }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
