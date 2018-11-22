To Test (`jobs-near-me-logic` branch):

1) `git pull origin jobs-near-me-logic`

2) `bundle`

3) `bundle exec figaro install`

4) Go to `https://www.zipcodeapi.com/Register` and register for an API key; use a real email

5) Confirm your email address

6) In `config/application.yml`, add the line `API_KEY: "<your API key>"`

7) pull down the `pass-jwt` branch to test with React or use Insomnia to test the `GET '/jobs'` route, passing a jwt in the Header.


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
