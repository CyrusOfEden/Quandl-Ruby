[![Gem Version](https://badge.fury.io/rb/quandl_ruby.svg)](http://badge.fury.io/rb/quandl_ruby)

# Quandl Ruby

A Ruby wrapper for the Quandl API (www.quandl.com).

## Installation

Add this line to your application's Gemfile:

    gem 'quandl_ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quandl_ruby

Then at the beginning of a file:

    require 'quandl'

## Usage

### Getting Started

If you've got an API key from Quandl, set it up as below. Feel free to otherwise skip this step.

```ruby
Quandl.configure do |config|
  config.auth_token = 'your quandl api key'
end
```

### The API

This library includes the following classes all namespaced under the `Quandl` module:

- [Dataset](http://www.quandl.com/help/api#A-Simple-Example)
- [Multiset](http://www.quandl.com/help/api#Multiple-Datasets)
- [Search](http://www.quandl.com/help/api#Doing-a-Search)
- [Metadata](http://www.quandl.com/help/api#Getting-Metadata)
- [Favorites](http://www.quandl.com/help/api#Getting-Favourites)

All the above classes have the same API:

```ruby
# Replace `Class` below with the relevant class from above.

# Query is the specific query for that class
# Options is an options hash containing data manipulation options

# Data manipulation docs:
#   http://www.quandl.com/help/api#Data-Manipulation

# Creating an instance doesn't retrieve the data
# Data format options:
#   `:json` => parsed JSON (default)
#   `:csv`  => parsed CSV into hashes
#   `:xml`  => a string of unparsed xml
# Set the format by providing a `:format` key in the options hash
# Quandl::Class.get is an alias for Quandl::Class.new
query = Quandl::Class.new(query, options)

# Use instance#data to retrieve data from Quandl
data = query.data

# Instantiating and then calling the `data` method memoizes the response
# Pass in `true` to instance#data to clear the cache
data = query.data(true)
```


#### An Alternative to Passing in an Options Hash

You can also pass in options by calling methods on an instance of a `Quandl::Class`:

```ruby
# This will make more sense if you read through:
#   http://www.quandl.com/help/api#Data-Manipulation
gdp = Quandl::Dataset.get('FRED/GDP')

# Corresponds to the `rows` parameter. Aliased as #rows.
gdp.limit(20)

# Corresponds to the `sort_order` parameter. Aliased as #sort.
gdp.order(:asc) # Only accepts :asc or :desc

# Corresponds to the `column` parameter.
gdp.column(4)

# Corresponds to the `collapse` parameter. Aliased as #frequency
# Accepts: :none, :daily, :weekly, :monthly, :quarterly, :annual
gdp.collapse(:annual)

# Corresponds to the `exclude_headers` parameter.
gdp.headers(false) # (sets `exclude_headers` to `true`)

# Corresponds to the `trim_start` parameter. Also accepts an instance of Date.
gdp.start('2010-01-01')

# Corresponds to the `trim_end` parameter. Also accepts an instance of Date.
gdp.end('2014-01-01')

# Corresponds to the `transformation` parameter.
# Accepts: :diff, :rdiff, :cumul, :normalize
gdp.transform(:normalize)

# After all the above, call #metadata or #data to retrieve the respective data
gdp.metadata # => returns metadata for 'FRED/GDP'
gdp.data # => returns metadata for 'FRED/GDP'

# If you were to change an option, like below:
gdp.transform(:rdiff)

# You'll need to call #reload! or pass `true` as an argument to #data or #metadata
gdp.reload!

gdp.data
```


### A Simple Example

```ruby
# Get the US GDP in JSON
#   Example from: http://www.quandl.com/help/api#A-Simple-Example
gdp = Quandl::Dataset.get('FRED/GDP')
```

### A Multiset Example
```ruby
# Annual percentage changes of US GDP, crude oil prices, and Apple stock for the last 10 years
#   Example from: http://www.quandl.com/help/api#A-Multiset-Example

datasets = ['FRED/GDP/1', 'DOE/RWTC/1', 'WIKI/AAPL/4']
comparison = Quandl::Multiset.get(datasets).
               collapse(:annual).
               transform(:rdiff).
               limit(10)
# Unlike the official Quandl REST API, separate source, table, and column numbers
# With `/` as opposed to `.` to maintain consistency with Quandl::Dataset
```

### Doing A Search

Note that Quandl::Search does not have access to the API option-setting methods. Instead, it has #per_page and #page, which correspond with the `per_page` and `page` url parameters of the Quandl API

```ruby
# Get search results for crude oil
#   Example from: http://www.quandl.com/help/api#Doing-a-Search
query = 'crude oil'
results = Quandl::Search.get(query).per_page(20).page(4)
```

### Getting Metadata

```ruby
# Retrieve only the metadata for a dataset
#   Example from: http://www.quandl.com/help/api#Getting-Metadata
oil_metadata = Quandl::Metadata.get('NSE/OIL')
```


### Getting Favorites

```ruby
# Retrieve a user's favorites
#   Example from: http://www.quandl.com/help/api#Getting-Favourites

# Defaults to getting the favorites of the user who's API key you've configured
my_favorites = Quandl::Favorites.get

# Or pass in another API key as the first argument to override your own
another_guys_favorites = Quandl::Favorites.get('that_guys_api_key')

# For Brits and Canucks, Quandl::Favorites is aliased as Quandl::Favourites
```


### Further Resources

Consult the [official API docs](http://www.quandl.com/help/api).


## Contributing

1. [Fork it](https://github.com/knrz/quandl/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
