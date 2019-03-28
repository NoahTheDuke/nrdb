FactoryBot.define do
  factory :user do
    username { 'noahtheduke' }
    email { 'nbtheduke@gmail.com' }
    password { 'password1234' }
    password_confirmation { 'password1234' }
  end
end
