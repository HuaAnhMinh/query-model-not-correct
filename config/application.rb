require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QueryModelNotCorrect
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.action_dispatch.trusted_proxies =
      ([
        '127.0.0.0/8', # localhost IPv4 range, per RFC-3330
        '::1',            # localhost IPv6
        'fc00::/7',       # private IPv6 range fc00::/7
        '10.0.0.0/8',     # private IPv4 range 10.x.x.x
        '172.16.0.0/12',  # private IPv4 range 172.16.0.0 .. 172.31.255.255
        '192.168.0.0/16' # private IPv4 range 192.168.x.x
      ] + (ENV['TRUSTED_PROXIES'].nil? ? [] : ENV['TRUSTED_PROXIES'].split(','))) # Env for firewall whitelisted ip ranges
      .map { |proxy| IPAddr.new(proxy) }
  end
end
