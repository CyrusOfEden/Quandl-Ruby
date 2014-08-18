# Quandl

Ruby wrapper for the Quandl API (www.quandle.com).

Currently supports Datasets, Metadata, and Searches.
Coming soon: Multisets and Favorites.

## Installation

Add this line to your application's Gemfile:

    gem 'quandl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quandl

## Usage

### Configuration

If you've got a Quandl API key, configure the Ruby API as below. If not, skip this step.

```ruby
Quandl.configure do |config|
  config.auth_token = (your api key)
end
```

### Getting A Dataset

To get a dataset, create a new `Quandl::Dataset`:

```ruby
gdp = Quandl::Dataset.new('FRED/GDP')

# To pass the data to a block provide a block to Quandl::Dataset#get,
# which will otherwise return the Quandl data
# Both of the following present the same data:
gdp.get do |data|
  # Do stuff with the data, by default in JSON format
end

data = gdp.get
```

`Quandl::Dataset#new` accepts an options hash as a second argument. Put anything that you would otherwise but as an argument in the url here.

```ruby
aapl = Quandl::Dataset.new('WIKI/AAPL', { format: 'csv', column: 4, collapse: 'annual' })
```


### Getting Metadata

The `Quandl::Metadata` API is exactly the same as the `Quandl::Dataset` API, except that it only returns metadata.

```ruby
oil = Quandl::Metadata.new('NSE/OIL')

oil.get # => returns metadata for 'NSE/OIL'
```


### Searching Quandl

The `Quandl::Search` API is exactly the same as the `Quandl::Dataset` API, except that it returns a query.

```ruby
results = Quandl::Search.new('crude oil')

results.get # => returns search results for 'crude oil'
```


## Contributing

1. [Fork it](https://github.com/knrz/quandl/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
