# README

# Packages version on my machine

* Ruby 3.3.0
* Rails ~> 7.1.3
* PostgresSQL 15

Other than that, everything else is defined in `Gemfile`.

# How to install dependencies

* Clone this repository
* Run `bundle install`
* Run `bundle exec rails db:create`
* Run `bundle exec rails db:migrate`

# Repo explanation

## Models

* Member
* Team
* TeamMember

## Services

* ReportsData::CallbackHandler: This is the service that is called when the hook is triggered when create, update, destroy a record of above models.
* ReportsData::ReportsDataHook: This is the service to call to inject the service callback above to active record for create, update, destroy.

## Initializers

* reports_data_hook_injection.rb: call class method inject of ReportsData::ReportsDataHook to inject the callback service to active record.

## Factories

* members.rb
* teams.rb
* team_members.rb

## Spec

* reports_data_hook_spec.rb: file test that causes the issue.

# Steps to reproduce the issue

## With gem `ruby-ide-debug`

* Set a breakpoint at line 29 `create(model.to_s.underscore.to_sym)` in test.
* Debug the test.
* When the process pauses at the breakpoint, click Step Over and the process will pause at keyword `end` below.
* Go to Interactive Console and type `Member.count` => the result is 0.
* Type `Member.first` => the result is `nil`.

Expected result: `Member.count` should return 1 and `Member.first` should return the created member.

## With gem `byebug`

* Uncomment line 34 `byebug` in test.
* Run `bundle exec rspec spec/reports_data_hook_spec.rb` to start testing.
* When the process pauses at the breakpoint, type `Member.count` => the result is 0.
* Type `Member.first` => the result is the created member.

=> Gem `byebug` shows correct results.