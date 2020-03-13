# ebay-ruby

A Ruby wrapper to the [eBay APIs]

## Usage

### Traditional Searching APIs

Search eBay; build search and browse experiences.

#### Finding API

The Finding API provides programmatic access to the next generation search capabilities on the eBay platform. It lets you search and browse for items listed on eBay and provides useful metadata to refine searches and enhance the search experience.

```ruby
require 'ebay/finding'

request = Ebay::Finding.new
response = request.find_items_by_keywords('tolkien')

JSON.parse(response)
```

### Traditional Shopping/Buying APIs

Retrieve public items and user data to create shopping and marketing applications.

#### Shopping API

The eBay Shopping API makes it easy to search for things on eBay.

```ruby
require 'ebay/shopping'

request = Ebay::Finding.new
response = request.find_products('QueryKeywords' => 'tolkien')

JSON.parse(response)
```

#### Merchandising API

The Merchandising API provides item and product recommendations that can be used to cross-sell and up-sell eBay items to buyers.

```ruby
require 'ebay/merchandising'

request = Ebay::Finding.new
response = request.get_most_watched_items

JSON.parse(response)
```

[eBay APIs]: https://developer.ebay.com/docs
