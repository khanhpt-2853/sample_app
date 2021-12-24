User.create!(
  name: "admin",
  email: "admin@gmail.com",
  password: "admin",
  password_confirmation: "admin",
  admin: true
)

100.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end
