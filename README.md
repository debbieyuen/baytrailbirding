# baytrailbirding

[![Build Status](https://travis-ci.com/rchunter/baytrailbirding.svg?branch=main)](https://travis-ci.com/rchunter/baytrailbirding)
[![Code Maintainability](https://api.codeclimate.com/v1/badges/c66f5c26d335b3d2b44d/maintainability)](https://codeclimate.com/github/rchunter/baytrailbirding/maintainability)
[![Code Coverage](https://api.codeclimate.com/v1/badges/c66f5c26d335b3d2b44d/test_coverage)](https://codeclimate.com/github/rchunter/baytrailbirding/test_coverage)
[![Bluejay Dashboard](https://img.shields.io/badge/Bluejay-Dashboard-informational.svg)](http://dashboard.bluejay.governify.io/dashboard/script/dashboardLoader.js?dashboardURL=https://reporter.bluejay.governify.io/api/v4/dashboards/tpa-CS169L-GH-rchunter_baytrailbirding/main)
[![Pivotal Tracker](https://img.shields.io/badge/Pivotal-Tracker-informational?logo=pivotal-tracker&logoColor=ffffff)](https://www.pivotaltracker.com/n/projects/2487649)

## Requirements

* Ruby 2.7
* Bundler 2

## Setup

Clone the repo, then install needed gems:

```bash
$ bundle install
```

Then, migrate the database:

```bash
$ bundle exec rails db:migrate
```

Then, start the server:

```bash
$ bundle exec rails server
```

## Testing

To run the Cucumber and RSpec tests:

```bash
$ bundle exec cucumber
$ bundle exec rspec
```
test
