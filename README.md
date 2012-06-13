# Shuffler

The aim of DebtShuffler is to make life easy for a person by shuffling debt
amongst his creditors / debtors such that he has fewer number of checks to write.

eg. Using DebtShuffler on Person 1 with the following scenario
Person 1 owes Person 2 => 30$
Person 3 owes Person 1 => 20$
Person 4 owes Person 1 => 10$

Person 1 will use debt shuffler to shuffle the debt between Person 2, 3, 4.
The output will be
Person 1 owes 0$ to anyone.
Person 2 will get $20 from Person 3 and $10 from Person 4


## Installation

Add this line to your application's Gemfile:

    gem 'shuffler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shuffler

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request