[![Gem Version](https://badge.fury.io/rb/quandl_ruby.svg)](http://badge.fury.io/rb/quandl_ruby)

# Quandl Ruby

A Ruby wrapper for the Quandl API (www.quandl.com).

## Installation

Add this line to your application's Gemfile:

    gem 'quandl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quandl

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
query = Quandl::Class.new(query, options)

# Use instance#get to retrieve data from Quandl
data = query.get

# Instantiating a calling the `get` method memoizes the response
# Pass in `true` to instance#get to clear the cache and reload the data
data = query.get(true)

# The following is a shortcut to Class.new(query, options).get,
# albeit with no build-in memoization:
data = Quandl::Class.get(query, options)
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
options = {
  collapse: 'annual',
  transformation: 'rdiff',
  rows: 10
}
comparison = Quandl::Multiset.new(datasets, options)
# Unlike the official Quandl REST API, separate source, table, and column numbers
# With `/` as opposed to `.` to maintain consistency with Quandl::Dataset
```

### Doing A Search

```ruby
# Get search results for crude oil
#   Example from: http://www.quandl.com/help/api#Doing-a-Search
query = 'crude oil'
options = {
  per_page: 100
}
results = Quandl::Search.get(query, options)
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
some_other_guys_favorites = Quandl::Favorites.get('that_guys_api_key')
```


### Further Resources

Consult the [official API docs](http://www.quandl.com/help/api).


## Contributing

1. [Fork it](https://github.com/knrz/quandl/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
