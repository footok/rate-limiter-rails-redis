require 'redis'

class HomeController < ApplicationController
  before_filter :throttle

  def index
    render :text => 'ok'
  end

  # Set & check redis key to prevent an user makes to many request
  # in given time. Currently set maximum request to 100 in 1 hour
  def throttle
    client_ip = request.remote_ip
    key = "request_count:#{client_ip}"
    count = REDIS.get(key)

    # Check the value of count. If it is nil, set the value of the key to 1
    # and set the expire time of the key.
    if count == nil
      REDIS.set(key, 1)
      REDIS.expire(key, THROTTLE_TIME_WINDOW)
      return true
    end

    # Set response status to 429 with error messages when the count is reach to the limit.
    if count.to_i >= THROTTLE_MAX_REQUESTS
      render :status => 429, :json => { 'message' => "Rate limit exceeded. Try again in #{REDIS.ttl(key)} seconds." }
      return
    end

    REDIS.incr(key)
  end
end
