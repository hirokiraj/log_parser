# Log Parser (Backups Remover)

## Installation

Written in Ruby 2.7.1

```sh
git clone git@github.com:hirokiraj/log_parser.git
cd log_parser
bundle install
```

## Usage

To run a very simplistic sinatra server that randomly emulates responses from backups removal API:

```sh
bundle exec ruby server/server.rb
```

Then run in another terminal session:

```sh
bundle exec ruby main.rb
```

Example input file is present in `inputs/logfile.txt`. Output will be saved to `outputs` directory.

Tests are written in RSpec, run them with:

```sh
bundle exec rspec .
```

To run Rubocop check just issue:

```sh
bundle exec rubocop
```
