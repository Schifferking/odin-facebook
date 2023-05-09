# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

def create_users(amount = 50)
  amount.times { User.create(user_data) }
end

def user_data
  data = email
  data[:gender] = gender
  data[:color] = color
  data[:password] = '123456'
  data
end

def email
  person_name = name
  email = Faker::Internet.email(name: first_name(person_name))
  { name: person_name, email: email }
end

def name
  Faker::Name.unique.name
end

def first_name(person_name)
  person_name.split.first
end

def gender
  Faker::Gender.type
end

def color
  Faker::Color.color_name
end

create_users
