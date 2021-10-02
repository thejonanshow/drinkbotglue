# frozen_string_literal: true

redis_url = +"redis://HOST:PORT/0"
redis_url.sub!(/HOST/, ENV["REDIS_HOST"] || "localhost")
redis_url.sub!(/PORT/, ENV["REDIS_PORT"] || "6379")

Subscriber = Redis.new(
  url:             redis_url,
  connect_timeout: ENV['REDIS_CONNECT_TIMEOUT'] || 30,
  read_timeout:    ENV['REDIS_READ_TIMEOUT'] || 5,
  write_timeout:   ENV['REDIS_WRITE_TIMEOUT'] || 5,
)

Publisher = Redis.new(
  url:             redis_url,
  connect_timeout: ENV['REDIS_CONNECT_TIMEOUT'] || 30,
  read_timeout:    ENV['REDIS_READ_TIMEOUT'] || 5,
  write_timeout:   ENV['REDIS_WRITE_TIMEOUT'] || 5,
)