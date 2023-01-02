# frozen_string_literal: true

require_relative('boot')

require('rails')

# Ignore active_storage/engine, instead of require rails/all
%w[
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  action_cable/engine
  rails/test_unit/railtie
  sprockets/railtie
].each do |railtie|
  require(railtie)
rescue LoadError
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UrlShortener
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.time_zone = 'Asia/Ho_Chi_Minh'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    require "#{config.root}/lib/rack/strip_x_forwarded_host"
    config.middleware.use(Rack::StripXForwardedHost)

    if Rails.env.in?(%w[heroku development test])
      require(Rails.root.join('swagger/definition'))
    end
  end
end
