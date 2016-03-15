# Database will be seeded with data in the file with a name matching the current environment
# RAILS_ENV=test #=> db:seed from `db/seeds/test.rb`
# RAILS_ENV=development #=> db:seed from `db/seeds/development.rb`
# RAILS_ENV=production #=> db:seed from `db/seeds/production.rb`
load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))

# Any record creation added here will be used to seed the database with universal default values.
