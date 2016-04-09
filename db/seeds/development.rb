# This file should contain all the record creation to seed the
# DEVELOPMENT database with its default values.
# The data can then be loaded with `$ bundle exec rake db:seed`.
# To create and seed a new database, use `$ bundle exec rake db:setup`.
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

###
# ADMIN
###

demo_admin = AdminUser.new(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
demo_admin.save! unless AdminUser.where(email: demo_admin.email).exists?

###
# QUESTIONNAIRES
###

# ORGANIZATION ACCOUNTS
org_qstr = Questionnaire.new(name: "organization")
org_qstr.save unless Questionnaire.where(name: org_qstr.name).exists?

org_q = [
"Organization Contact Person",
"Are you exempt from taxation pursuant to 26 U.S.C 501 ( c )(3)?",
"Are you a School District?",
"School District Name",
"Are you a Special District?",
"Special District Name"
]

org_q.each do |question|
  q = Question.new(question_text: question, questionnaire_id: org_qstr.id)
  q.save unless Question.exists? q
end

# INDIVIDUAL ACCOUNTS
ind_qstr = Questionnaire.new(name: "individual")
ind_qstr.save unless Questionnaire.where(name: ind_qstr.name).exists?

ind_q = [
"Are you receiving CalFresh benefits?",
"Are you receiving CalWORKS benefits?",
"Are you receiving County Relief benefits?",
"Are you receiving General Relief benefits?",
"Are you receiving General Assistance benefits?",
"Are you receiving MediCal benefits?"
]

ind_q.each do |question|
  q = Question.new(question_text: question, questionnaire_id: ind_qstr.id)
  q.save unless Question.exists? q
end

###
# USERS
####

# ORGANIZATION ACCOUNTS
10.times do
  user = User.new(
    name: Faker::Name.name,
    entity_name: Faker::Company.name + " " + Faker::Company.suffix,
    entity_license: Faker::Company.ein,
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password",
    account_type: "organization"
  )
  user.save
  user.questionnaires << Questionnaire.find_by(name: user.account_type)
end

# INDIVIDUAL ACCOUNTS
10.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password",
    account_type: "individual"
  )
  user.save
  user.questionnaires << Questionnaire.find_by(name: user.account_type)
end

###
# LISTINGS & CATEGORIES
###
category_names = ["furniture", "hygeine", "vehicle", "clothing", "school/office supplies", "computers", "non-perishable foods"]

category_names.each do |c|
  Category.new(name: c).save!
end

all_users = User.all.to_a
categories = Category.all.to_a
all_users.each do |u|
  3.times do
    listing = u.listings.build(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      fair_market_value: rand(250).abs
    )
    listing.save
    listing.categories << categories.sample
  end
end

###
# USERS
####

### DEMO ###
ind_demo = User.new(
  name: "Jane Smith",
  email: "ind@example.com",
  password: "password",
  password_confirmation: "password",
  account_type: "individual"
)
ind_demo.save unless User.exists? ind_demo

org_demo = User.new(
  name: "Jane Smith",
  entity_name: Faker::Company.name + " " + Faker::Company.suffix,
  entity_license: Faker::Company.ein,
  email: "org@example.com",
  password: "password",
  password_confirmation: "password",
  account_type: "individual"
)
org_demo.save unless User.exists? org_demo

sac_demo = User.new(
  name: "Christine",
  entity_name: "Sacramento County",
  email: "saccounty@example.com",
  password: "password",
  password_confirmation: "password",
  account_type: "organization"
)
sac_demo.save unless User.exists? sac_demo


### FAKER ###
# Organizations
10.times do
  user = User.new(
    name: Faker::Name.name,
    entity_name: Faker::Company.name + " " + Faker::Company.suffix,
    entity_license: Faker::Company.ein,
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password",
    account_type: "organization"
  )
  user.save
  user.questionnaires << Questionnaire.find_by(name: user.account_type)
end

# Individuals
10.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password",
    account_type: "individual"
  )
  user.save
  user.questionnaires << Questionnaire.find_by(name: user.account_type)
end

###
# LISTINGS & CATEGORIES
###
category_names = ["furniture", "hygeine", "vehicle", "clothing", "school/office supplies", "computers"]

category_names.each do |c|
  Category.new(name: c).save!
end

all_users = User.all.to_a
categories = Category.all.to_a
all_users.each do |u|
  3.times do
    listing = u.listings.build(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      fair_market_value: rand(250).abs
    )
    listing.save
    listing.categories << categories.sample
  end
end

### Sac County Listings ###
sac = User.find_by(email: "saccounty@example.com")
sac_listings = Listing.all.to_a
10.times do
  sac.listings << sac_listings.sample
end
