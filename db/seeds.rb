User.create!(username: 'NoahTheDuke',
             email: 'nbtheduke@gmail.com',
             password: 'password1234',
             password_confirmation: 'password1234')

99.times do |n|
  name  = Faker::Name.name[0...20]
  email = "example-#{n + 1}@example.com"
  password = 'password1234'
  User.create!(username: name,
               email: email,
               password: password,
               password_confirmation: password)
end
