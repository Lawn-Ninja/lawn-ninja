# README

**To run Lawn Ninja API**

1) Terminal: `git clone https://github.com/Lawn-Ninja/lawn-ninja.git && cd lawn-ninja`

2) Terminal: `rails db:create && rails db:migrate && rails db:seed`; this may take a few minutes

3) Terminal: `bundle`

4) Terminal: `bundle exec figaro install`

5) Terminal: `touch config/master.key && echo '<MASTER KEY>' >>./config/master.key`; the master key can currently be obtained from anyone on the development team

6) Go to `https://www.zipcodeapi.com/Register` and register for an API key; use a real email

7) Confirm your email address

8) In `config/application.yml`, add the line `API_KEY: "<your API key>"`

9) `rails s -p 3001`


**Version Info**

Ruby version: 2.5.1


**Significant Gemfile Modifications**
```ruby
# Authentication and Security
gem 'jwt'
gem 'bcrypt', '~> 3.1.7'
gem 'figaro'

# Debugging & Clean Code
gem 'pry'
gem 'responders'

# Web Requests
gem "loofah", ">= 2.2.3"
gem "rack", ">= 2.0.6"
gem 'rack-cors', :require => 'rack/cors'
gem "http"
```

The unirest gem was removed due to its dependency on an insecure version of the rack gem. The http gem functions in much the same way as unirest.


**Significant Technologies**
* http gem
* ZipCodeAPI


**Other Concepts**
* Strong Params
