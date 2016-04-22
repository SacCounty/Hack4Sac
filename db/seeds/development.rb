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

q = Question.new(question_text: "Organization Contact Person", questionnaire_id: org_qstr.id, question_type: "text")
q.save unless Question.exists? q
q = Question.new(question_text: "Are you exempt from taxation pursuant to 26 U.S.C 501 ( c )(3)?", questionnaire_id: org_qstr.id, question_type: "yes_no")
q.save unless Question.exists? q
q = Question.new(question_text: "Are you a School District?", questionnaire_id: org_qstr.id, question_type: "yes_no")
q.save unless Question.exists? q
q = Question.new(question_text: "School District Name", questionnaire_id: org_qstr.id, question_type: "text")
q.save unless Question.exists? q
q = Question.new(question_text: "Are you a Special District?", questionnaire_id: org_qstr.id, question_type: "yes_no")
q.save unless Question.exists? q
q = Question.new(question_text: "Special District Name", questionnaire_id: org_qstr.id, question_type: "text")
q.save unless Question.exists? q

# INDIVIDUAL ACCOUNTS
ind_qstr = Questionnaire.new(name: "individual")
ind_qstr.save unless Questionnaire.where(name: ind_qstr.name).exists?

q = Question.new(question_text: "Are you receiving CalFresh benefits?", questionnaire_id: ind_qstr.id, question_type: "yes_no")
q.save unless Question.exists? q
q = Question.new(question_text: "Are you receiving CalWORKS benefits?", questionnaire_id: ind_qstr.id, question_type: "yes_no")
q.save unless Question.exists? q
q = Question.new(question_text: "Are you receiving County Relief benefits?", questionnaire_id: ind_qstr.id, question_type: "yes_no")
q.save unless Question.exists? q
q = Question.new(question_text: "Are you receiving General Relief benefits?", questionnaire_id: ind_qstr.id, question_type: "yes_no")
q.save unless Question.exists? q
q = Question.new(question_text: "Are you receiving General Assistance benefits?", questionnaire_id: ind_qstr.id, question_type: "yes_no")
q.save unless Question.exists? q
q = Question.new(question_text: "Are you receiving MediCal benefits?", questionnaire_id: ind_qstr.id, question_type: "yes_no")
q.save unless Question.exists? q

###
# USERS
####

sac_demo = User.new(
  entity_name: "Sacramento County",
  email: "saccounty@example.com",
  password: "password",
  password_confirmation: "password",
  account_type: "organization"
)
sac_demo.save unless User.exists? sac_demo
sac_demo.questionnaires << Questionnaire.find_by(name: sac_demo.account_type)
@sac_laptop = sac_demo.listings.build(title: "20 Laptop computers", fair_market_value: 200, image_url: "http://etaarifa.com/wp-content/uploads/2015/03/laptops.jpg")
@sac_laptop.save



hs_demo = User.new(
  entity_name: "Grant Union High School",
  email: "demo@example.com",
  password: "password",
  password_confirmation: "password",
  account_type: "organization"
  )
hs_demo.save unless User.exists? hs_demo
hs_demo.questionnaires << Questionnaire.find_by(name: hs_demo.account_type)
hs_demo.addresses.build(street_address_1: "1400 Grand Ave", city: "Sacramento", state: "Ca", zip_code: "95838", primary: true, address_type: "physical").save

10.times do
  hs_demo.contact_infos.build(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  title: "Teacher",
  phone: "555-" + Random.rand(100..999).to_s + "-" + Random.rand(1000..9999).to_s,
  primary: false
  ).save
end

hs_demo.contact_infos.build(
  first_name: "Peter",
  last_name: "Whittlesey",
  title: "Librarian/Computer Lab Manager",
  phone: "555-" + Random.rand(100..999).to_s + "-" + Random.rand(1000..9999).to_s,
  primary: true
  ).save

# FAKER Organizations + Contacts
10.times do
  user = User.new(
    entity_name: Faker::Company.name + " " + Faker::Company.suffix,
    entity_license: Faker::Company.ein,
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password",
    account_type: "organization"
  )
  user.save
  user.questionnaires << Questionnaire.find_by(name: user.account_type)
  user.contact_infos.build(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    title: Faker::Name.title,
    phone: "555-" + Random.rand(100..999).to_s + Random.rand(1000..9999).to_s,
    primary: false
    ).save
end

# FAKER Individuals + Contacts
10.times do
  user = User.new(
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password",
    account_type: "individual"
  )
  user.save
  user.questionnaires << Questionnaire.find_by(name: user.account_type)
  user.contact_infos.build(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  title: Faker::Name.title,
  phone: "555-" + Random.rand(100..999).to_s + "-" + Random.rand(1000..9999).to_s,
  primary: false
  ).save
end

###
# LISTINGS & CATEGORIES
###

image_links = ["https://www.elementalled.com/wp/wp-content/uploads/2012/08/google-food-350.jpg", "http://www.gsmnation.com/blog/wp-content/uploads/2013/03/20-8.jpg", "http://s3-ap-southeast-2.amazonaws.com/wc-prod-pim/JPEG_1000x1000/OWMOBWTBRD_ucomm_ucomm_mobile_whiteboard_900_x_1200_mm_white.jpg", "http://thinura-japan.com/wp-content/uploads/2015/09/carfleet2.png", "http://ecx.images-amazon.com/images/I/81aGEMCnvKL._SL1500_.jpg", "http://42e7xc172a051i7v1iyv99nn.wpengine.netdna-cdn.com/wp-content/uploads/2013/09/selling-used-baby-clothes.jpg", "http://www.vermontsystems.com/images/hardware/computers/Computer.jpg"]

category_names = ["furniture", "hygiene", "vehicle", "clothing", "school/office supplies", "computers", "non-perishable foods"]

category_names.each do |c|
  Category.new(name: c).save!
end

all_users = User.all.to_a
categories = Category.where.not(name: "computers")
all_users.each do |u|
  3.times do
    listing = u.listings.build(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      fair_market_value: rand(250).abs,
      image_url: image_links.sample
    )
    listing.save
    listing.categories << categories.sample
  end
end

###
# USERS
####
non_sac_demo = User.find(17)
generic_pc = non_sac_demo.listings.build(title: "11 Desktop computers", fair_market_value: 200, image_url: "http://www.pullman-wa.gov/images/stories/parksrecrandoms/computers2.jpeg")
generic_pc.save

### FAKER ###
# Organizations
10.times do
  user = User.new(
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
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password",
    account_type: "individual"
  )
  user.save
  user.questionnaires << Questionnaire.find_by(name: user.account_type)
end

### Sac County Listings ###
sac = User.find_by(email: "saccounty@example.com")
sac_listings = Listing.all.to_a
10.times do
  sac.listings << sac_listings.sample
end

@sac_laptop.categories << Category.find_by(name: "computers")
generic_pc.categories << Category.find_by(name: "computers")

### Give Sac County Listing some applicants
user_sample = User.where.not(email: hs_demo.email)
user_sample.each do |user| DonationApplication.new(listing: @sac_laptop, applicant: user, submission_date: Time.now).save end

