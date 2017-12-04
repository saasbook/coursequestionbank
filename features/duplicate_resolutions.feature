# PTID: 152624808
Feature: User can delete a duplicate Problem
  As an instructor
  In order to resolve duplicates
  I want to delete a duplicate problem

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'dup_test_first.txt'
  And I am on the upload page
  And I attach the file "features/test_files/dup_test_second.txt" to "file_upload"
  And I press "Upload File"
