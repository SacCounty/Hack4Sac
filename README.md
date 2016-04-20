# SHARE (Sacramento's Human Assistance Resource Exchange)

## Project Description
The mission of SHARE is to break down the silos between government agencies and organizations that share the common goal of providing Human Assistance. For example, the Food Bank networks with local food pantries, a School District networks with schools under its administration, and the Homeless Assistance agency networks with local homeless shelters. Sometimes their constituents overlap, but these agencies know little about each other's needs, available resources, and data. SHARE addresses this disparity on two fronts: first, it's a platform for organizations and individuals to reach out to each other to provide resources or request resources that other agencies have in surplus, like clothing, furniture, non-perishable foods, computers, and more. Second, it supports the civic open data initiative by collecting anonymous data that is released as an API* (see **Additional Information** section). This will provide other civic developers and researchers invaluable cross-sectional data that could uncover insights as to common issues shared by different types of HA programs or initiatives that work well in one agency that can be applied to another.

## Contributors
- Christine Feaster (@femmestem), christine@hax.help
- Erik C. Olson (@erikcaineolson), erik@hax.help
- Neal Fennimore (@nealfennimore), neal@hax.help
- Joanne Wu (@joawu), joanne@hax.help

### Stakeholder Engagement
- Jerry Gray, DTech (Sac County Dept of Technology)
- Guy Sperry, DTech (Sac County Dept of Technology)
- Keith Arnett, DTech (Sac County Dept of Technology)

## Developer Documentation
### Requirements
 - <a href="http://git-scm.com/" target="_blank">Git</a>
 -  Ruby 2.2 (<a href="https://rvm.io/rvm/install" target="_blank">RVM</a> recommended for managing Ruby versions)
 -  Rails 4.2
 -  Postgres >= 9.3
 - <a href="https://github.com/sstephenson/execjs" target="_blank">ExecJS</a> supported JavaScript runtime (therubyracer gem is included)

To check your ruby version, run `$ ruby --version`. If your version is 2.2.0, then you’re good to go.

If not, download <a href="https://rvm.io/rvm/install" target="_blank">RVM</a> if not already installed, then run `$ rvm list` to see your installed ruby versions. If you have 2.2.0 installed, run `$ rvm use ruby-2.2.0`. Otherwise, install or update your ruby version with RVM.

1. Download or clone this repository from GitHub `$ git clone https://github.com/HumanAssistanceResourceExchange/SHARE.git SHARE`
2. Change directory into the project folder `$ cd SHARE`
3. Download dependencies `$ gem install bundler` then `$ bundle install`
4. Set up the Postgres database (see **Database** section below)
5. Run `$ rails server`
6. Point your browser to `localhost:3000` to preview the app

#### API Keys
We are using <a href="https://github.com/laserlemon/figaro" target="_blank">Figaro</a> for key management.

To install, run `$ bundle exec figaro install`

This will create a key management YAML file at `app/config/application.yml` and add it to your `.gitignore`. This config file should *not* be committed to the repo. Please edit this file on your local machine as new keys are added.

Figaro is deployment-friendly and values can be set for Heroku with:

```
figaro heroku:set -e production
```

#### PDF Form Fill
We are using PDF Toolkit (pdftk) from PDF Labs. This requires you to install pdftk binaries before you can make use of the pdf-forms gem bundled in this project.

Download and install the appropriate package for your platform:

 - [Mac OS X 10.10 (Yosemite)](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-mac_osx-10.11-setup.pkg) and below
 - [Windows 8](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-win-setup.exe) and below

#### Database
1. Install PostgreSQL
2. Create the database `$ bundle exec rake db:create`
3. Load the schema `$ bundle exec rake db:schema:load`
4. (Optional) Seed the database with default admin user and starter data `$ bundle exec rake db:seed`
 - Note: The default behavior for db:seed has been modified to use different datasets based on environment. See notes in the `seeds.rb` file.

### Additional Information
We respect our organizational users and their constituents, so we take precautions to ensure neither are exploited intentionally or accidentally by using our app. Considering the sensitive nature of services provided by our users, the database schema and API are designed to separate user information (real names) from addresses and from app activity. For example, the API may provide data as to how many users requested resources from a certain category, and whether they were individuals or organizations making the request, but not which users. The API may provide data as to how many users are in a certain zipcode, but not which users nor specific addresses. The API may provide data showing how many users made requests to multiple agencies, but not which users made the request. The API does *not* allow viewing whether a specific individual requested or received specific types of donations or from which agency.
