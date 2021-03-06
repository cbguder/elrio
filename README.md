# Elrio

Cap inset detector & optimizer for resizable UIKit assets.

<a href="https://travis-ci.org/cbguder/elrio"><img src="https://travis-ci.org/cbguder/elrio.svg?branch=master" alt="Build Status"></a>
<a href="https://codeclimate.com/github/cbguder/elrio"><img src="https://codeclimate.com/github/cbguder/elrio.png" alt="Code Climate"></a>
<a href="https://codeclimate.com/github/cbguder/elrio"><img src="https://codeclimate.com/github/cbguder/elrio/coverage.png" alt="Test Coverage"></a>
<a href='https://gemnasium.com/cbguder/elrio'><img src="https://gemnasium.com/cbguder/elrio.png" alt="Dependency Status" /></a>
<a href="http://badge.fury.io/rb/elrio"><img src="https://badge.fury.io/rb/elrio@2x.png" alt="Gem Version" height="18"></a>

## Installation

Add this line to your application's Gemfile:

    gem 'elrio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elrio

## Usage

  To get the resizable cap insets for an asset:

    $ elrio analyze image.png

  To create an optimized version of the asset:

    $ elrio optimize image.png

## Example

  When run with this image:

  ![Source Image](https://raw.github.com/cbguder/elrio/master/spec/fixtures/original.png)

    $ elrio optimize image.png
    image.png: [48, 48, 48, 48] # Top, Left, Bottom, Right

  This optimized version is written to `image-optimized.png`:

  ![Source Image](https://raw.github.com/cbguder/elrio/master/spec/fixtures/optimized.png)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
