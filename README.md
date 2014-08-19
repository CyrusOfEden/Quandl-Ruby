# Quandl

Ruby wrapper for the Quandl API (www.quandle.com).

Supports:

- Datasets
- Metadata
- Multisets
- Searches
- Favorites

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
  config.auth_token = 'your auth token here'
end
```

### Getting A Dataset

To get a dataset, create a new `Quandl::Dataset`:

```ruby
gdp = Quandl::Dataset.get('FRED/GDP')
```

`Quandl::Dataset#new` accepts an options hash as a second argument. Put anything that you would otherwise but as an argument in the url here.

```ruby
aapl = Quandl::Dataset.get('WIKI/AAPL', {
  format: 'csv',
  column: 4,
  collapse: 'annual'
})
```


### Getting Metadata

The `Quandl::Metadata` API is exactly the same as the `Quandl::Dataset` API, except that it only returns metadata.

```ruby
oil = Quandl::Metadata.get('NSE/OIL')
```


### Using Multisets

The `Quandl::Multiset` class allows you to build multisets for yourself. Accepts `options` hash as a secondary argument to the initializer.

```ruby
example = Quandl::Multiset.get(['FRED/GDP/1', 'WIKI/AAPL/4'])
```

Unlike the official Quandl API, use `/` (instead of `.`) as your delimiter for source, table, and column number to maintain consistency with `Quandl::Dataset`.


### Searching Quandl

The `Quandl::Search` API is exactly the same as the `Quandl::Dataset` API, except that it returns a query.

```ruby
results = Quandl::Search.get('crude oil')
```


### Retrieving Favorites

The `Quandl::Favorites` API allows you to retrieve the favorites of any user.

```ruby
# If an authorization token was previously configured with Quandl.configure,
# then one is not required for Quandl::Favorites.get

favs = Quandl::Favorites.get(
  :auth_token => 'an auth token here'
  # Any other options here
)
```


## Contributing

1. [Fork it](https://github.com/knrz/quandl/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
