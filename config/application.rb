require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "action_dispatch/railtie"
require "action_cable"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"
# require "mongoid/railtie"
require "carrierwave"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

require_relative './markdown.rb'
Bundler.require(*Rails.groups)

module HanksHou
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.time_zone = 'Beijing'
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.i18n.default_locale = "zh-CN"
    # config.log_level = :error
    config.generators do |g|
      g.template_engine     :slim
      g.javascript_engine   :js
      g.scaffold_stylesheet false
      g.jbuilder            false
    end



    config.autoload_paths += Dir[Rails.root.join('app', 'entities', '*')]

    require Rails.root.join("lib/errors/error_exceptions")
    config.exceptions_app = ErrorExceptions.new(Rails.public_path)
  end
end
