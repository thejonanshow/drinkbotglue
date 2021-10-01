# frozen_string_literal: true

Subscriber = Redis.new(
  url:  ENV['REDIS_URL'] || 'redis://localhost:6379/0',
  connect_timeout: ENV['REDIS_CONNECT_TIMEOUT'] || 30,
  read_timeout:    ENV['REDIS_READ_TIMEOUT'] || 5,
  write_timeout:   ENV['REDIS_WRITE_TIMEOUT'] || 5,
)

Publisher = Redis.new(
  url:  ENV['REDIS_URL'] || 'redis://localhost:6379/0',
  connect_timeout: ENV['REDIS_CONNECT_TIMEOUT'] || 30,
  read_timeout:    ENV['REDIS_READ_TIMEOUT'] || 5,
  write_timeout:   ENV['REDIS_WRITE_TIMEOUT'] || 5,
)