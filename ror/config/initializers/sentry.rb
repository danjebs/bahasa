# frozen_string_literal: true

Sentry.init do |config|
  config.breadcrumbs_logger = [:active_support_logger]
  config.dsn = Rails.application.credentials[:sentry][:dsn]
  config.enable_tracing = true
  config.enabled_environments = %w[production]
end
