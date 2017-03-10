require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SistemaDocumentosProcuradoria
  class Application < Rails::Application
    config.encoding = 'utf-8'
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'America/Fortaleza'
    config.i18n.default_locale = :'pt-BR'
    config.i18n.available_locales = %w(pt-BR en)
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.precompile += %w( .svg .otf .eot .woff .ttf)

    config.active_record.raise_in_transactional_callbacks = true
  end
end
