This repository includes the two files that **must be included** in all project submissions for Sacramento County's [Hack4Sac Civic Tech Challenge](http://hack4sac.saccounty.net/):

1. this `README` containing instructions and information to include in your submission; and,
2. a `LICENSE` that allows anyone to do anything they want with your code as long as they provide attribution back to you and don’t hold you liable.

## Project Information

### Project Name
HARE (Human Assistance Resource Exchange)

### Project Description
The mission of HARE is to break down the siloes between departments and organizations that share the common goal of providing Human Assistance. For example, the Food Bank networks with local food pantries, a School District networks with schools under its administration, and the Homeless Assistance agency networks with local homeless shelters. Sometimes their constituents overlap, but these agencies know little about each other's needs, available resources, and data. HARE addresses this disparity on two fronts: first, it's a platform for organizations and individuals to reach out to each other to provide resources or request resources that other agencies have in surplus, like clothing, furniture, non-perishable foods, computers, and more. Second, it supports the civic open data initiative by collecting anonymous data that is released as an API* (see **Additional Information** section). This will provide other civic developers and researchers invaluable cross-sectional data that could uncover insights as to common issues shared by different types of HA programs or initiatives that work well in one agency that can be applied to another.

### Team Members
- Christine, christine@hax.help
- Erik, erik@hax.help
- Neal, neal@hax.help
- Joanne, joanne@hax.help
- Koni, koni@hax.help

### Stakeholder Engagement
- Jerry Gray, DTech (Sac County Dept of Technology)
- Guy Sperry, DTech (Sac County Dept of Technology)
- Keith Arnett, DTech (Sac County Dept of Technology)

### Developer Documentation
#### Requirements
 - <a href="http://git-scm.com/" target="_blank">Git</a>
 -  Ruby 2.2 (<a href="https://rvm.io/rvm/install" target="_blank">RVM</a> recommended for managing Ruby versions)
 -  Rails 4.2
 -  Postgres >= 9.3
 - <a href="https://github.com/sstephenson/execjs" target="_blank">ExecJS</a> supported JavaScript runtime (therubyracer gem is included)

To check your ruby version, run `$ ruby --version`. If your version is 2.2.0, then you’re good to go.

If not, download <a href="https://rvm.io/rvm/install" target="_blank">RVM</a> if not already installed, then run `$ rvm list` to see your installed ruby versions. If you have 2.2.0 installed, run `$ rvm use ruby-2.2.0`. Otherwise, install or update your ruby version with RVM.

1. Download or clone this repository from GitHub `$ git clone https://github.com/erikcaineolson/HARE.git HARE`
2. Change directory into the project folder `$ cd HARE`
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

### Additional Information (optional)
We respect our organizational users and their constituents, so we take precautions to ensure neither are exploited intentionally or accidentally by using our app. Considering the sensitive nature of services provided by our users, the database schema and API are designed to separate user information (real names) from addresses and from app activity. For example, the API may provide data as to how many users requested resources from a certain category, and whether they were individuals or organizations making the request, but not which users. The API may provide data as to how many users are in a certain zipcode, but not which users nor specific addresses. The API may provide data showing how many users made requests to multiple agencies, but not which users made the request. The API does *not* allow viewing whether a specific individual requested or received specific types of donations or from which agency.

## Submission Instructions

### Step 1: Fork this Repository
By forking this repository, we'll be able to find your project which will allow the judges to review your submission. Please note that cloning this repository or copying the contents of this `README` to your project will not allow us to find your project. Learn more about [how to fork a project repository](https://help.github.com/articles/fork-a-repo/).

### Step 2: Rename Your New Project Repository
You probably want your project to have a name other than `Hack4Sac`, so go ahead and rename your project repository. Also, feel free to edit the description and URL of your deployed app at the top of your repository on GitHub.

### Step 3: Add Your Project Files
As long as you keep this `README.md` file in your repository, hack away on your project to your heart's content.

### Step 4: Add Your Team Information
Add your project name, description, and team members at the top of this file by [committing changes](https://help.github.com/articles/adding-a-file-to-a-repository-from-the-command-line/). In the `LICENSE` file, replace `[fullname]` with the name of the individual(s) or team you want attributed to your project. *Hint: a [commit history](https://github.com/rust-lang/rust/commits/master/README.md) will provide valuable information to the judges about the work your team invested in developing your particular solution.*

### Step 5: Submit Your Project
Guess what? If you've already forked this repository, then you've already submitted your project. On April 12, 2016, the judges will review all of [the repositories listed here](https://github.com/SacCounty/Hack4Sac/network/members). If your repository is not listed, [please let us know](mailto:hack4sac@saccounty.net).

**IMPORTANT: If you haven't already done so, make sure you've joined the Hack4Sac Slack Community**
- [Sign up](http://slackin.saccounty.net)
- [Login](https://hackforsac.slack.com)

### Optional: Waffle.io Hackshop Tools

*Hint: while optional, these tools will result in projects that help meet the needs of users and help the judges better understand the thinking behind your particular solution.*

#### To use these tools, first replace `GITHUB_ACCOUNT` with the GitHub username or organization name to which you forked this repository so that the links correctly work.

[![Stories Ready to Work On](https://badge.waffle.io/GITHUB_ACCOUNT/project-submission-template.svg?label=ready&title=Cards%20Ready%20To%20Work%20On)](https://waffle.io/GITHUB_ACCOUNT/project-submission-template)

This repo was created from http://hackshop.waffle.io. Use [the Waffle board](https://waffle.io/GITHUB_ACCOUNT/project-submission-template) for this repo to always know what to do next for your hackshop project!

#### Why Hackshops?

##### Transparent, Simple Tooling
We’ve put together the right set of tools to help teams be productive in the shortest period of time. In addition to helping teams move fast, this tool set will allow transparency for optimized community engagement and easy continuation of the project following the event.

##### Learn Lean by Being Lean
Hackshops apply lean principles to hackathons. By using the Hackshop format, hackathon teams can expect to learn:
- how to maximize resources in hyper-limited time constraints
- how to validate with customers before building the wrong thing
- how to document a brief, living, and lean business model
- how to continually test assumptions with rapid experimentation to deliver an MVP

Hackshops are still hackathons. The difference is the addition of the Hackshop framework for running in a lean way, to be as efficient as possible, focused on continuously experimenting and learning throughout the development process.

##### The Traditional Hackathon
Hackathons traditionally center around building solutions, the most time-consuming and expensive part of the development lifecycle.

Individuals and teams show up to the event already knowing what they plan to build. Sometimes, problem statements are pre-defined, which is a step in the right direction -- but what if you're not passionate about the problem to be solved? Or what if you already have an amazing solution in mind?

Unfortunately, your amazing solution is probably not actually as amazing as you think. You may have even skipped identifying what the underlying problem is altogether. You could spend 24 hours coding a chat app for retired seniors only to find out that 10% of them use smart phones.

##### The Hackshop Way
Hackshops focus on problems and customers first. What problem are you solving and for who are you solving it? Can you make a compelling promise to that customer that you can deliver a solution that meets their needs? Before we even talk about solutions, we focus on the customer, problem, and promise, first.

We've learned that when starting with a problem or an idea, the more we can be wrong, faster, the more we can get to a solution worth building. This approach sounds backwards, because your solution is so obviously brilliant, right? Unfortunately, probably not. Solutions that go from idea to launch without any attempt to validate or invalidate the underlying problem with a customer segment and if your solution fits their needs are rarely successful.

The Hackshop format leaves the traditional hackathon's solution-centric format behind. Hackshops focus on customers, problems, and promises first, and advocate moving quickly using succinct timeboxes to get from idea to MVP as quickly as possible. Throughout the event, teams work to prove their own assumptions wrong on their path to a viable solution.

#### Hackshops vs. Hackathons

##### 5 Unique Elements
- problem-centric approach (no solutions for the first 1/4 of the event)
- use of a [lean business canvas](https://github.com/waffleio/hackshop-playbook/raw/master/resources/leancanvas.pdf) as central to process
- customer validation before building
- rapid prototyping and experimentation
- use of continuous feedback loop (frame/build/measure/learn)

##### Recommended (Lightweight) Tooling
- An electronic or paper version of a [lean business canvas](https://github.com/waffleio/hackshop-playbook/raw/master/resources/leancanvas.pdf)
- GitHub, for collaboration on code and issues
- [hackshop.waffle.io](https://hackshop.waffle.io), a pre-built project template for managing issues in GitHub using a lean workflow
- [Slack](http://hackforsac.slack.com), for remote and ongoing communications (optional)

#### Hackshops specifically limit risk around:
- solving problems that aren't painful or impactful
- building the wrong thing for the wrong customer
- post-hackathon death due to lack of focus or centralization of team/data
