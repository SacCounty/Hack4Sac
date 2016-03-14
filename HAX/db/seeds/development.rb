# This file should contain all the record creation to seed the
# DEVELOPMENT database with its default values.
# The data can then be loaded with `$ bundle exec rake db:seed`.
# To create and seed a new database, use `$ bundle exec rake db:setup`.
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
