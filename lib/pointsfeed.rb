require "pointsfeed/version"
require 'faraday'
require 'json'
require 'hashie'

module Pointsfeed
  extend self

  class Config
    attr_accessor :token
  end

  @connection = Faraday.new(:url => 'http://localhost:3000/api/')
  @config = Config.new

  def configure
    yield(@config)
  end

  def user_info(user)
    response = @connection.get("feeds/#{user}.json?access_token=#{@config.token}")
    check_response(response)
    Hashie::Mash.new(JSON.parse(response.body))
  end

  def feed(user)
    response = @connection.get("feeds/#{user}/items.json?access_token=#{@config.token}")
    check_response(response)
    JSON.parse(response.body).map { |r| Hashie::Mash.new(r) }
  end

  def post_text(content)
    response = @connection.post("posts", { 
      :type => "TextItem", 
      :"post[content]" => content,
      :access_token => @config.token
    })
    check_response(response)
  end

  def post_image(url, comment='')
    response = @connection.post("posts", { 
      :type => "ImageItem", 
      :"post[content]" => url,
      :"post[comment]" => comment,
      :access_token => @config.token
    })
    check_response(response)
  end

  def post_link(url, comment='')
    response = @connection.post("posts", { 
      :type => "LinkItem", 
      :"post[content]" => url,
      :"post[comment]" => comment,
      :access_token => @config.token
    })
    check_response(response)
  end

  def refeed(id)
    post = post_id_to_user(id)
    response = @connection.post("feeds/#{post.feeder.name}/items/#{id}/refeeds.json", {
      :access_token => @config.token
    })
    check_response(response)
  end

  private

  def post_id_to_user(id)
    response = @connection.get("posts/#{id}.json")
    check_response(response)
    Hashie::Mash.new(JSON.parse(response.body))
  end

  def check_response(response)
    status = response.env[:status]

    if status == 401 || status == 403
      raise 'Unable to access - make sure your authentication token is valid'
    elsif status == 400
      raise 'Page not found (404 returned)'
    end
  end
end