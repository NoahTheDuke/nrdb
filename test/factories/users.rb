FactoryBot.define do
  factory :user do
    username { 'noahtheduke' }
    email { "#{SecureRandom.uuid}@example.com" }
  end
end
