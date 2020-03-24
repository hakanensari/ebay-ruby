# ebay-ruby

[![Build](https://github.com/hakanensari/ebay-ruby/workflows/build/badge.svg)](https://github.com/hakanensari/ebay-ruby/actions)

A Ruby wrapper to the [eBay APIs]

## Usage

### Buy APIs

Retrieve purchasable items, check out, then track orders without visiting the eBay site.

#### [Browse API]

Using the Browse API, you can create a rich selection of items for your buyers to browse with keyword and category searches. You can also provides the ability to eBay members to add items and change the quantity of an item in their eBay shopping cart as well as view the contents of their eBay cart.

```ruby
require 'ebay/browse'
require 'ebay/oauth/client_credentials_grant'

request = Ebay::Browse.new(campaign_id: '123',
                           country: 'US',
                           zip: '19406',
                           access_token: access_token)
response = request.search(q: 'iphone')

JSON.parse(response)
```

### Traditional Searching APIs

Search eBay; build search and browse experiences.

#### [Finding API]

The Finding API provides programmatic access to the next generation search capabilities on the eBay platform. It lets you search and browse for items listed on eBay and provides useful metadata to refine searches and enhance the search experience.

```ruby
require 'ebay/finding'

request = Ebay::Finding.new(response_data_format: 'JSON')
response = request.find_items_by_keywords('iphone')

JSON.parse(response)
```

### Traditional Shopping/Buying APIs

Retrieve public items and user data to create shopping and marketing applications.

#### [Shopping API]

The eBay Shopping API makes it easy to search for things on eBay.

```ruby
require 'ebay/shopping'

request = Ebay::Shopping.new(response_encoding: 'JSON')
response = request.find_products('QueryKeywords' => 'tolkien')
access_token = Oauth::ClientCredentialsGrant.mint_access_token

JSON.parse(response)
```

#### [Merchandising API]

The Merchandising API provides item and product recommendations that can be used to cross-sell and up-sell eBay items to buyers.

```ruby
require 'ebay/merchandising'

request = Ebay::Merchandising.new(response_data_format: 'JSON')
response = request.get_most_watched_items

JSON.parse(response)
```

[eBay APIs]: https://developer.ebay.com/docs
[Browse API]: https://developer.ebay.com/api-docs/buy/browse/static/overview.html
[Finding API]: https://developer.ebay.com/Devzone/finding/Concepts/FindingAPIGuide.html
[Shopping API]: https://developer.ebay.com/Devzone/shopping/docs/Concepts/ShoppingAPIGuide.html
[Merchandising API]: https://developer.ebay.com/Devzone/merchandising/docs/Concepts/merchandisingAPIGuide.html
