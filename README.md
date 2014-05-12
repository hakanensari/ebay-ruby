# ebay-ruby

A wrapper to the eBay APIs in Ruby

```ruby
require 'ebay/finding'

finding = Ebay::Finding.new
params = {
  'GLOBAL-ID'      => 'EBAY-US',
  'OPERATION-NAME' => 'findItemsByKeywords',
  'keywords'       => 'minimalism'
}
parser = finding.get(query: params)
parser.parse
```
