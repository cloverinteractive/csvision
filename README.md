# CSVision

Convert a Hash into a CSV the easy way.

## Installation

Add this line to your application's Gemfile:

`gem 'csvision'`

And then execute:

`bundle`

Or install it yourself as:

`gem install csvision`

## Usage

CSVision has no prerequisites other than ruby itself, which is pretty cool just include the `CSVision` module into your app and you'll be good to go.

### Hash

CSVision adds to `Hash` the `to_csv` method, anything that inherits from `Hash` will inherit this method as well, you do not need to open `Hash` and include `CSVision` in it, just add it anywhere in your code.

```ruby
include CSVision
sample = { :name => 'foo', :last_name => 'bar', :age => 10 }
sample.to_csv #=> "\"last_name\",\"name\",\"age\"\n\"bar\",\"foo\",\"10\""
```
### Rails

CSVision adds the Rails the methods:

1. `to_csv` at the model instance
2. `to_csv` at the model class
3. `add_csvision` at the model class

A rails model might look something like this:

```ruby
class Product < ActiveRecord::Base
  validates_presence_of :name, :permalink, :description
  add_csvision :except => %w/updated_at created_at/
end
```

CSVision lets you customize the way your CSV is formed, you can use any of the following options in the `add_csvision` method:

1. `:only` to set only those parameters you wish to include.
2. `:except` this does the opposite it excludes options from the list.
3. `:delimeter` this set the field delimeter and it defaults to `"`
4. `:separator` this set the field separator and it defults to `,`

## TODO:

1. Allow users to set their own list of parameters
2. Add support for other ORM's
3. Rails 3.x responder.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
