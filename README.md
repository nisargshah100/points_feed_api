# Pointsfeed

Communicate with PointsFeed.in via api.

## Installation

Add this line to your application's Gemfile:

    gem 'pointsfeed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pointsfeed

## Usage

```
PointsFeed.configure do |config|
  config.token = '[your token]'
end

PointsFeed.feed(display_name)
PointsFeed.user_info(display_name)
PointsFeed.text_post(msg)
PointsFeed.image_post(link, comment)
PointsFeed.link_post(link, comment)
PointsFeed.refeed(id)

```
