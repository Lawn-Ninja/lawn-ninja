# README

## To run Lawn Ninja API

1) Terminal: `git clone https://github.com/Lawn-Ninja/lawn-ninja.git && cd lawn-ninja`

2) Terminal: `rails db:create && rails db:migrate && rails db:seed`; this may take a few minutes

3) Terminal: `bundle`

4) Terminal: `bundle exec figaro install`

5) Terminal: `touch config/master.key && echo '<MASTER KEY>' >>./config/master.key`; the master key can currently be obtained from anyone on the development team

6) Go to `https://www.zipcodeapi.com/Register` and register for an API key; use a real email

7) Confirm your email address

8) In `config/application.yml`, add the line `API_KEY: "<your API key>"`

9) `rails s -p 3001`


## Version Info

Ruby version: 2.5.1


## Significant Gemfile Modifications
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
gem "rest-client", "1.8.0"
gem 'rack-cors', :require => 'rack/cors'
gem "http"

# Other
gem 'bootstrap', '~> 4.1.2'
gem 'jquery-rails'
gem 'faker'
```

The unirest gem was removed due to its dependency on an insecure version of the rest-client gem. The http gem functions in much the same way as unirest.


## Significant Technologies

* bcrypt gem

* http gem

* ZipCodeAPI


## Other Concepts

* Strong Params


## json keys

### jobs

**create**

```json
{
  "job": {
    "requested_time": "<requested_time:datetime>"
  }
}
```

* `requested_time` is required to create a job

**update**

```json
{
  "job": {
    "status": "<status:string>",
    "provider_id": "<provider_id:integer>",
    "requested_time": "<requested_time:datetime>",
    "start_time": "<start_time:datetime>",
    "end_time": "<end_time:datetime>"
  }
}
```

* all keys are optional in job updates, but the job will not save if `requested_time` is updated to something that isn't a valid datetime.

### users

**create**

```json
{
  "user": {
    "email": "<email:string>",
    "password": "<password:string>",
    "password_confirmation": "<password_confirmation:string>",
    "address": "<address:string>",
    "city": "<city:string>",
    "state": "<state:string>",
    "zip_code": "<zip_code:string>",
    "phone_number": "<phone_number:string>",
    "provider": "<provider:boolean>"
  }
}
```

* `email` is required to create a user

* `password` is required to create a user

* `password_confirmation` is optional but must match `password` exactly if provided

* `address` is optional

* `city` is optional

* `state` is optional

* `zip_code` is optional, although it should be required

* `phone_number` is optional

* `provider` is optional; since it is a boolean value, a nil/null will be treated the same as a false (that is, by default, users are not providers)

**update**

```json
{
  "user": {
    "email": "<email:string>",
    "address": "<address:string>",
    "city": "<city:string>",
    "state": "<state:string>",
    "zip_code": "<zip_code:string>",
    "phone_number": "<phone_number:string>",
    "provider": "<provider:boolean>"
  }
}
```

* all keys are optional in user updates; password updates have not yet been tested or considered