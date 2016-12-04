# Course Question Bank - CS 169 Project
[![Code Climate](https://codeclimate.com/github/hrzlvn/coursequestionbank/badges/gpa.svg)](https://codeclimate.com/github/hrzlvn/coursequestionbank)
[![Travis CI](https://travis-ci.org/hrzlvn/coursequestionbank.svg?branch=master)](https://travis-ci.org/hrzlvn/coursequestionbank)
[![Test Coverage](https://codeclimate.com/github/hrzlvn/coursequestionbank/badges/coverage.svg)](https://codeclimate.com/github/hrzlvn/coursequestionbank/coverage)
<span style="background-color: blue; text-decoration:none; font: Verdana 7px bold; color:white; padding: 2px; margin: 2px;" ><a style="background-color: blue; text-decoration:none; font: Verdana 7px bold; color:white; padding: 2px; margin: 2px;" href="https://www.pivotaltracker.com/n/projects/1544183">PivotalTracker</a></span>

# Status
Our six-students team (from UC Berkeley CS169) will be working on the development until December 2016.

# User Guide
See the [Wiki](https://github.com/saasbook/coursequestionbank/wiki).

# Running or Testing Locally
##For local testing:
`bundle install --without production`
`rake db:migrate`
`rake db:seed`
`rake db:test:prepare`
`rake run`

# Deployment
For Heroku deployment:
Install ProsgreSQL and Websolr after deployment, otherwise it simply won't work.
Websolr worker supposed to periodically re-indexes the questions so that keyword search will work; you can run it manually with `heroku run rake sunspot:solr:reindex`. [Course Question Bank on Heroku](https://coursequestionbank.herokuapp.com/)

