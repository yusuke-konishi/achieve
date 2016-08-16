# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin
5.times do |m|
  name = Faker::StarWars.character
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
  
  20.times do |n|
    title = Faker::Hacker.noun
    content = Faker::Hacker.say_something_smart
    Blog.create!(title: title,
                 content: content,
                 user_id: m+1,
                 )
  end
end
=end