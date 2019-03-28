FactoryBot.define do
  factory :user do
    username { 'noahtheduke' }
    email { "#{SecureRandom.uuid}@example.com" }
    password { '012345678901' }
    password_confirmation { '012345678901' }
  end
end
