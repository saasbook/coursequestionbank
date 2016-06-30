# Course Question Bank - CS 169 Project

[![Code Climate](https://codeclimate.com/github/jshoe/coursequestionbank/badges/gpa.svg)](https://codeclimate.com/github/jshoe/coursequestionbank)
[![Travis CI](https://travis-ci.org/jshoe/coursequestionbank.svg?branch=master)](https://travis-ci.org/jshoe/coursequestionbank)
[![Test Coverage](https://codeclimate.com/github/jshoe/coursequestionbank/badges/coverage.svg)](https://codeclimate.com/github/jshoe/coursequestionbank/coverage)
<span style="background-color: blue; text-decoration:none; font: Verdana 7px bold; color:white; padding: 2px; margin: 2px;" ><a style="background-color: blue; text-decoration:none; font: Verdana 7px bold; color:white; padding: 2px; margin: 2px;" href="https://www.pivotaltracker.com/n/projects/1544183">PivotalTracker</a></span>

## User Guide

See the Wiki.

## Deployment

Currently set up to deploy to Heroku.  There is a Websolr worker that periodically re-indexes the questions so that keyword search will work; you can run it manually with `heroku run rake sunspot:solr:reindex`

## To Do

* The URL `questionbank.saasbook.info` points to the running app, but for now you must access it as `cs-coursequestionbank.herokuapp.com` until we get a proper SSL cert for the new name and change the GitHub OAuth callback URL to match the vanity domain.
* It's in private beta with core group of [ESaaS instructors](http://www.saasbook.info).  Armando Fox or Sam Joseph can add you to the beta whitelist if you're part of that core group.
