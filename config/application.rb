require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module IotAws
  class Application < Rails::Application
    config.load_defaults 5.1
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

  end
end
