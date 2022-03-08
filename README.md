# baytrailbirding
![Build Status](https://github.com/debbieyuen/baytrailbirding/actions/workflows/ci.yml/badge.svg)
[![Code Maintainability](https://api.codeclimate.com/v1/badges/c66f5c26d335b3d2b44d/maintainability)](https://codeclimate.com/github/rchunter/baytrailbirding/maintainability)
[![Code Coverage](https://api.codeclimate.com/v1/badges/c66f5c26d335b3d2b44d/test_coverage)](https://codeclimate.com/github/rchunter/baytrailbirding/test_coverage)
[![Bluejay Dashboard](https://img.shields.io/badge/Bluejay-Dashboard_baytrailbirding-blue.svg)](http://dashboard.bluejay.governify.io/dashboard/script/dashboardLoader.js?dashboardURL=https://reporter.bluejay.governify.io/api/v4/dashboards/tpa-CS169L-22-GH-debbieyuen_baytrailbirding/main)
[![Pivotal Tracker](https://img.shields.io/badge/Pivotal-Tracker-informational?logo=pivotal-tracker&logoColor=ffffff)](https://www.pivotaltracker.com/n/projects/2487649)

## Spring 2022 CS169L 
[![Maintainability](https://api.codeclimate.com/v1/badges/16ea022179c7200774ff/maintainability)](https://codeclimate.com/github/debbieyuen/baytrailbirding/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/16ea022179c7200774ff/test_coverage)](https://codeclimate.com/github/debbieyuen/baytrailbirding/test_coverage)

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

To run ESLint:
```bash
$ npm install
$ npm run lint
$ npm run lint:fix
```
