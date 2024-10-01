Sidekiq.configure_server do |config|
  redis_url = if Rails.env.production?
                ENV["REDIS_URL"] # 本番環境のURL（例: HerokuのRedisアドオンなど）
              else
                'redis://localhost:6379/0' # 開発環境のURL
              end

  config.redis = {
    url: redis_url,
    ssl_params: Rails.env.production? ? { verify_mode: OpenSSL::SSL::VERIFY_NONE } : {}
  }
end

Sidekiq.configure_client do |config|
  redis_url = if Rails.env.production?
                ENV["REDIS_URL"] # 本番環境のURL
              else
                'redis://localhost:6379/0' # 開発環境のURL
              end

  config.redis = {
    url: redis_url,
    ssl_params: Rails.env.production? ? { verify_mode: OpenSSL::SSL::VERIFY_NONE } : {}
  }
end
