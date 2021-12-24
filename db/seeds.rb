User.create!(name: "Example",
             surname: "User",
             email: "example@gmail.com",
             phone: "+375331234567",
             password: "12345678",
             password_confirmation: "12345678")

99.times do |n|
  name = Faker::Name.name
  surname = Faker::Kpop.boy_bands
  email = "example-#{n + 1}@gmail.com"
  phone= "+37533#{1000000 + Random.rand(1000000)}"
  password = "12345678"
  User.create!(name: name,
               surname: surname,
               phone: phone,
               email: email,
               password: password,
               password_confirmation: password)
  end
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
  end