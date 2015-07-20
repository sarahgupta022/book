require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'net/http'



if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Book
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

    # Do not swallow errors in after_commit/after_rollback callbacks.
    #Configure the defult encoding used in template for Ruby 1.9
    config.encoding = "utf-8"
    
    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    
    #Configure sensitive parameters which will be filtered from the log file.
    config.active_support.escape_html_emtities_in_json = true
    
    
    # Enable the asset pipeline
    config.assets.enabled = false
     
    config.active_record.raise_in_transactional_callbacks = true
    
    # Version of your assets, change the if you want to expire all your assets
    config.assets.version = '1.0'
    config.assets.initialize_on_precompile = true
    
    # adds app/assets/fonts to the asset path
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.paths << Rails.root.join("app", "assets", "audios")
  end
end
