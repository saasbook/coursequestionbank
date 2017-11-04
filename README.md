# Course Question Bank - CS 169 Project
[![Code Climate](https://codeclimate.com/github/hrzlvn/coursequestionbank/badges/gpa.svg)](https://codeclimate.com/github/Laralinmcc/coursequestionbank)
[![Travis CI](https://travis-ci.org/hrzlvn/coursequestionbank.svg?branch=master)](https://travis-ci.org/Laralinmcc/coursequestionbank)
[![Test Coverage](https://codeclimate.com/github/hrzlvn/coursequestionbank/badges/coverage.svg)](https://codeclimate.com/github/Laralinmcc/coursequestionbank/coverage)
<span style="background-color: blue; text-decoration:none; font: Verdana 7px bold; color:white; padding: 2px; margin: 2px;" ><a style="background-color: blue; text-decoration:none; font: Verdana 7px bold; color:white; padding: 2px; margin: 2px;" href="https://www.pivotaltracker.com/n/projects/1544183">PivotalTracker</a></span>
[![Coverage Status](https://coveralls.io/repos/github/Laralinmcc/coursequestionbank/badge.svg?branch=fall2017_features)](https://coveralls.io/github/Laralinmcc/coursequestionbank?branch=fall2017_features)

# Video Links

Client Entry Video - https://youtu.be/oNJuf9Z29W0 
Screencast Video - https://youtu.be/EVNBPCu02wQ

# User Guide
See the [Wiki](https://github.com/saasbook/coursequestionbank/wiki).

## Running or Testing Locally

You need to run a Solr process during local development (or Cloud9 for those who used it). So `bundle exec sunspot-solr start -p 8983` to start and `bundle exec sunspot-solr stop` to stop (basically the steps in `.travis.yml`). And the config in `sunspot.yml` should enable the app to connect properly.

When running locally, you can click the "Dev Login" button and login as either `saas` (Instructor privilege) or `saas-admin` (Admin privilege) with no password needed.

## Deployment

Currently set up to deploy to Heroku.  

0. Provision a Heroku app and add the Websolr and Rollbar addons.  There is a Websolr
worker that periodically re-indexes the questions so that keyword search
will work; you can run it manually with `heroku run rake
sunspot:solr:reindex`

0. Login to your GitHub account, go to Settings, then OAuth
applications.  Click "Register new application" and fill in the fields
as follows:
  * Application name: something you or your students will recognize
  * Homepage URL: `https://`_yourappname_`.herokuapp.com`
  * Description: something your students will recognize, or can leave
  blank
  * Callback URL: `https://`_yourappname_`.herokuapp.com/auth/github/callback`
Make note of the "Client ID" and "Client Secret" GitHub assigns when you
register the app.

0. In the Rollbar addon for Heroku, generate a Rollbar access token if
you don't already have one.

0. You now need to tell Heroku the GitHub client and secret as well as the
Rollbar access token.  You can do this two ways.
  * Manually: in the Heroku app dashboard, go to Config Variables and
  manually enter values for `github_key`, `github_secret`, and
  `ROLLBAR_ACCESS_TOKEN` (case is significant).
  * Semi-automatically: The app expects to find a
[Figaro](https://github.com/laserlemon/figaro)-friendly
`config/application.yml` file with the keys `github_key` (client ID),
`github_secret`, and `ROLLBAR_ACCESS_TOKEN`.  Create the file, then run `figaro heroku:set -e
production` to propagate these values ti Heroku.

0. Deploy:  `git push heroku master`

0. Setup the remote database: `heroku run rake db:migrate`

0. Create the initial admin user based on their GitHub username: `heroku
run rake setup:add_admin[github-username-here]`

You should now be able to login.
