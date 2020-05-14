require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MembershipRegister
  mattr_accessor :society_name, :basic_auth_options
  self.society_name = ENV['SOCIETY_NAME']

  class Application < Rails::Application
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = ENV.fetch('APP_TIMEZONE', 'Pacific/Auckland')

    if ENV['CANONICAL_HOST']
      config.middleware.insert_before ActionDispatch::SSL, Rack::CanonicalHost, ENV['CANONICAL_HOST']
    end

  end

  self.basic_auth_options = Rails.application.secrets.basic_auth_options.symbolize_keys
end
