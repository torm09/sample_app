require File.expand_path('../boot', __FILE__)

require 'rails/all'

# # Pick the frameworks you want:
# require "active_record/railtie"
# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "active_resource/railtie"
# require "sprockets/railtie"
# # require "rails/test_unit/railtie"

if defined?(Bundler)
  # Require the gems listed in Gemfile, including any gems
  # you've limited to :test, :development, or :production.

  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test production)))
  # Bundler.require(:default, Rails.env)
end

module SampleApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.before_initialize do
      %w(development).each do |e|
        custom_configure = File.join(Rails.root, 'config', "#{e}.yml")
        YAML.load(File.open(custom_configure)).each do |key, value|
          ENV[key.to_s] = value
        end if File.exists?(custom_configure)
      end
    end
  end
end
