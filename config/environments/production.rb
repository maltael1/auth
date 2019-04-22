Rails.application.configure do
  config.cache_classes = true
  config.secret_key_base = 'YourSecretKeyHereomgitskey'
  config.eager_load = true
  config.discovery_host = 'http://registrator.ya-o.ru/api/v0/register_service' # Хост сервис провайдера
  config.service_token = '6baa78dbd73ae22e88e084967df2fc30' # Токен сервиса аутентификации

  config.host = 'http://auth.ya-o.ru'
  config.gate_host = 'http://auth.ya-o.ru/gate'

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.active_storage.service = :local

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :log

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
  RegisterServiceJob.set(wait: 3.seconds).perform_later
end
