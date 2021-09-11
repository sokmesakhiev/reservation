## System Requirement

* Ruby version 3.0.1

* Rails 6.1.4

* Postgres 13.2

### Rails Setup

The current required Ruby version is 3.0.1. We recommend you use a Ruby version
manager to handle parallel installations of different Ruby versions.
[rbenv](https://github.com/rbenv/rbenv) and [RVM](http://rvm.io) are both
supported.

1. Install the bundle:

    ```
    bundle install
    ```

2. Create and setup de database

    ```
    bundle exec rake db:setup
    ```

### Running in development

Once the application has been setup, run the application in development mode:

    bundle exec rails server

### Running the tests

Execute the unit tests through [Rspec](http://rspec.info):

    bundle exec rspec
