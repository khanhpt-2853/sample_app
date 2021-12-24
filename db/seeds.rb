User.create!(
  name: "admin",
  email: "admin@gmail.com",
  password: "admin",
  password_confirmation: "admin",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

100.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end
