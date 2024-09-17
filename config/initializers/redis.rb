if Rails.env.production?
  $redis = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
else
  REDIS = Redis.new(url: 'redis://localhost:6379/0')
end
