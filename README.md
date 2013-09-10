# Elrio

Cap inset detector & optimizer for resizable UIKit assets.

[![Code Climate](https://codeclimate.com/github/cbguder/elrio.png)](https://codeclimate.com/github/cbguder/elrio)
[![Build Status](https://travis-ci.org/cbguder/elrio.png)](https://travis-ci.org/cbguder/elrio)

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
