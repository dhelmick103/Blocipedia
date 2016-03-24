require 'faker'

# Create Users
 10.times do
   user = User.new(
       email: Faker::Internet.email,
       password: Faker::Internet.password(8)
   )
   user.skip_confirmation!
   user.save!
 end

# Admin User
user =  User.new(
      email: 'dhelmick103@gmail.com',
      password: 'helloworld',
      confirmed_at: DateTime.now
    )
    user.admin!
    user.save!

users = User.all
# Create Wikis
45.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
end

# Create Member User
  member = User.new(
      username: 'Member',
      email:    'member@fake.com',
      password: 'password1',
      role:     'standard'
  )
  member.skip_confirmation!
  member.save!
end

# Create Premium Member
member = User.new(
     username: 'Premium',
     email:    'premium@example.com',
     password: 'helloworld',
     role:     'premium'
   )
   member.skip_confirmation!
   member.save!
end

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created."
