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
org_qstr.save! unless Questionnaire.where(name: org_qstr.name).exists?

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
  q.save! unless Question.exists? q
end

# INDIVIDUAL ACCOUNTS
ind_qstr = Questionnaire.new(name: "individual")
ind_qstr.save! unless Questionnaire.where(name: ind_qstr.name).exists?

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
  q.save! unless Question.exists? q
end


