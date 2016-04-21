require 'faker'

# Create Users
 10.times do
   user = User.new(
       email: Faker::Internet.email,
       password: Faker::Internet.password(10),
       name: Faker::Name.name
   )
   user.skip_confirmation!
   user.save!
 end

 users = User.all

# Admin User
admin =  User.new(
      email: 'dhelmick103@gmail.com',
      password: 'helloworld',
      confirmed_at: DateTime.now,
    )
    admin.admin!
    admin.save!


# Create Wikis
45.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
end
Wikis = Wiki.all

# Create Standard User
  standard = User.new(
      username: 'Member',
      email:    'standard@fakemail.com',
      password: 'password1',
      role:     'standard'
  )
  standard.skip_confirmation!
  standard.save!


# Create Premium Member
premium = User.new(
     username: 'Premium',
     email:    'premium@fakemail.com',
     password: 'password1',
     role:     'premium'
   )
   premium.skip_confirmation!
   premium.save!


 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created."
