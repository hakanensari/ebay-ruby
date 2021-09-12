# ebay-ruby

[![Build](https://github.com/hakanensari/ebay-ruby/workflows/build/badge.svg)](https://github.com/hakanensari/ebay-ruby/actions)

This library provides a wrapper to the [eBay APIs].

## Getting started

You can instantiate API requests using shorthand class methods defined on `Ebay`.

```ruby
Ebay.finding # returns a new Ebay::Finding instance
```

### Keys

eBay APIs require [developer keys].

You can provide these globally with the environment variables `EBAY_APP_ID`, `EBAY_DEV_ID`, and `EBAY_CERT_ID`.

If you prefer not to use environment variables, you can provide your keys globally with:

```ruby
Ebay.configure do |config|
  config.app_id = 'YOUR APP ID'
  config.dev_id = 'YOUR DEV ID'
  config.cert_id = 'YOUR CERT ID'
end
```

Finally, you can provide your keys individually to the request when instantiating it. This is what you will want to do if you are using multiple sets of credentials.

Please note that each API names keys differently.

```ruby
request = Ebay.finding(security_appname: 'YOUR APP ID')
```

In the examples below, we will assume we are providing our keys with environment variables.

### Parsing a response

The eBay APIs return responses in XML or JSON format.

You can override the default format of an API when instantiating the request.

```ruby
require 'json'

### the Finding API returns XML by default
request = Ebay.finding(response_data_format: 'JSON')
response = request.find_items_by_keywords('iphone')

JSON.parse(response)
```

## Usage
### [Browse API]

The Browse API allows your buyers to search eBay items by keyword and [category](https://pages.ebay.com/sellerinformation/news/categorychanges/preview2021.html). It also allows them to view and add items to their eBay shopping cart. The Browse API defaults to the eBay US marketplace but may be set during initialisation. The list of available marketplaces is [here](https://developer.ebay.com/api-docs/static/rest-request-components.html#marketpl).

**Note** The marketplace value needs to use an underscore between EBAY and the country code.  The Finding and Merchandising APIs use a hyphen.

```ruby
require 'ebay/browse'
require 'ebay/oauth/client_credentials_grant'

access_token = Oauth::ClientCredentialsGrant.new.mint_access_token
request = Ebay.browse(campaign_id: '123', country: 'US', zip: '19406',
                      access_token: access_token, market_id: 'EBAY_US')
response = request.search(q: 'iphone')
```

### [Finding API]

The Finding API lets you search and browse for items listed on eBay and provides useful metadata to refine searches.

```ruby
require 'ebay/finding'

request = Ebay.finding
response = request.find_items_by_keywords('iphone')
```

### [Merchandising API]

The Merchandising API retrieves information about products or item listings on eBay to help you sell more merchandise to eBay buyers.

```ruby
require 'ebay/merchandising'

request = Ebay::Merchandising.new
response = request.get_most_watched_items
```

### [Shopping API]

The eBay Shopping API makes it easy to search for things on eBay.

```ruby
require 'ebay/shopping'

request = Ebay::Shopping.new
response = request.find_products('QueryKeywords' => 'tolkien')
```

### Market Place
eBay has country bsaed marketplaces ( listed [here](https://developer.ebay.com/api-docs/static/rest-request-components.html#marketpl) ).  By default, the eBay gem queries the US Marketplace.  To change the marketplace, set the marketplace on the request object.

**Note** For the Browse API, the marketplace value needs to use an underscore between EBAY and the country code (EBAY_AU).  The Finding and Merchandising APIs require a hyphen between EBAY and the country code ( EBAY-AU )

## Development

To write requests and responses to a logger, use the logging feature:

```ruby
require 'logger'

request = request.use(logging: {logger: Logger.new(STDOUT)})
```

[eBay APIs]: https://developer.ebay.com/docs
[developer keys]: https://developer.ebay.com/my/keys
[Browse API]: https://developer.ebay.com/api-docs/buy/browse/static/overview.html
[Finding API]: https://developer.ebay.com/Devzone/finding/Concepts/FindingAPIGuide.html
[Merchandising API]: https://developer.ebay.com/Devzone/merchandising/docs/Concepts/merchandisingAPIGuide.html
[Shopping API]: https://developer.ebay.com/Devzone/shopping/docs/Concepts/ShoppingAPIGuide.html
