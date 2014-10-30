# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)






10.times do
  User.create!(username: Faker::Internet.user_name, password: "hunter2" )
end

10.times do |i|
  Cat.create!(user_id: (i + 1), name: Faker::Name.first_name, color: Cat::COLORS.sample, sex: Cat::SEX.sample)
end

cat_ids = (1..Cat.all.size).to_a

10.times do |i|
  start_dt = Faker::Date.between(10.days.ago, Date.today)
  end_dt = Faker::Date.forward(10)

  CatRentalRequest.create!(user_id: (i + 1), start_date: start_dt, end_date: end_dt, cat_id: cat_ids.sample)
end