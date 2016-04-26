# S3::Authorize

[![Build Status](https://travis-ci.org/vinhnglx/s3-authorize.svg?branch=master)](https://travis-ci.org/vinhnglx/s3-authorize)

S3 accepts uploads via specially-crafted and pre-authorized HTML POST Form (http://aws.amazon.com/articles/1434/). This gem will help you create two values: Signature and Policy.

You guys can use this gem when working with upload file by AngularJS -  (https://github.com/danialfarid/ng-file-upload#s3) or Cordova File Transfer plugin (https://github.com/apache/cordova-plugin-file-transfer) or any front-end stack.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 's3-authorize'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install s3-authorize

## Usage


```ruby
require 's3/authorize'

s3_authorize = S3::Authorize.new(bucket: 'example', acl: 'public-read', 'secret_key': '356789032')

s3_policy = s3_authorize.policy # eyJleHBpcmF0aW9uIjoiMjAxNi0wNC0yNlQxOTozNjowNFoiLCJjb25 ....

s3-signature = s3_authorize.signature(s3_policy) # VR9hEPY0zvMHOt ....
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vinhnglx/s3-authorize. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
