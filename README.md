# CSVision

[![Build Status](https://secure.travis-ci.org/cloverinteractive/csvision.png?branch=master)](http://travis-ci.org/cloverinteractive/csvision)

Convert a Hash into a CSV the easy way.

## Installation

Add this line to your application's Gemfile:

`gem 'csvision'`

And then execute:

`bundle`

Or install it yourself as:

`gem install csvision`

## Usage

CSVision has no prerequisites other than ruby itself, which is pretty cool just include the `csvision` gem in your app and you'll be good to go.

### Hash

CSVision adds to `Hash` the `to_csv` method, anything that inherits from `Hash` will inherit this method as well, you do not need to open `Hash` and include `CSVision` in it, just require the library in your code.

```ruby
require 'csvision'
sample = { :name => 'foo', :last_name => 'bar', :age => 10 }
sample.to_csv #=> "\"last_name\",\"name\",\"age\"\n\"bar\",\"foo\",\"10\""
```
### Rails

CSVision adds the following methods to Rails:

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

That's good and all but, you never want to just convert a single object to csv but collections instead, so imagine this model instead:

```ruby
class User < ActiveRecord::Base
  add_csvision :csv_headers => %w/street_cred nickname incognito/, :body => lambda { |u| [ u.street_cred, u.nickname, u.incognito ] }

  scope :flunky, where( 'points <= 5' )

  def incognito
    nickname.reverse
  end

  def street_cred
    points * 100 + ( nickname_cred )
  end

  private
  def nickname_cred
    nickname.unpack( 'U' * nickname.length ).sum # good nickname equals more street cred
  end
end
```

You can use the `:headers` option to set your header names, and the `:body` option to specify the methods or properties from the option you want
called in your csv, this gives you flexibility to choose how your csv is formed and from what it is formed, so this is an example of how this works.

```ruby
5.times { |i| User.create( :nickname => "user#{ i * 3 }", :points => i * 5 ) }
puts User.to_csv
```

this will print:

```
"street_cred","nickname","incognito"
"495","user0","0resu"
"998","user3","3resu"
"1501","user6","6resu"
"2004","user9","9resu"
"2546","user12","21resu"
```

You can chain active record calls and even scopes in to your mix, so consider:

```ruby
5.times { |i| User.create( :nickname => "user#{ i * 3 }", :points => i *5 ) }
puts User.flunky.to_csv
```
will print:

```
"street_cred","nickname","incognito"
"495","user0","0resu"
"998","user3","3resu"
"1501","user6","6resu"
```

Lastly, with the exception of `:except` and `:only` which will be ignore because you're setting the body manually all other option work:

```ruby
5.times { |i| User.create( :nickname => "user#{ i * 3 }", :points => i *5 ) }
puts User.to_csv( :headers => false )
```

Will print:

```
"495","user0","0resu"
"998","user3","3resu"
"1501","user6","6resu"
"2004","user9","9resu"
"2546","user12","21resu"
```

### Outside of Rails

Anything that inherits from `Hash` will `respond_to? :to_csv` however if you want to use this in any other regular class make sure you do the following:

1. Create a `Hash` attribute named `attributes`.
2. You'll need to have class `count` and `find_each` methods if you want support for setting the `body`.
3. `include CSVision` in your class.

```ruby
class SampleStack
  include CSVision
  attr_accessor :attributes

  add_csvision :csv_headers => %w/price name/, :body => lambda { |s| [ s[:name], s[:price] ] }

  def initialize( attributes={}, inventory = [] )
    @attributes = attributes
    @@inventory = inventory
  end

  def self.count
    @@inventory.size
  end

  def self.find_each( opts={} )
    @@inventory.each do |item|
      yield item
    end
  end
end
```

After wards imagine the following:

```ruby
sample_stack = SampleStack.new( :foo => 'foo', :bar => 'bar' )
puts sample_stack.to_csv
```

Will print:

```
"foo","bar"
"foo","bar"
```

But more importantly `to_csv` at the class level will:

```ruby
inventory = [ { :name => 'beer', :price => 9 }, { :name => 'milk', :price => 5 }, { :name => 'tuna', :price => 3 } ]
sample_stack = SampleStack.new({ :name => 'groceries'}, inventory)
puts SampleStack.to_csv
```

Prints:

```
"price","name"
"beer","9"
"milk","5"
"tuna","3"
```

## TODO:

1. Add support for other ORM's
2. Rails 3.x responder.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
