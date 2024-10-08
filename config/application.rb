require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsBasic
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
    # Generators configuration
    config.generators do |g|
      g.skip_routes true       # ルーティングファイルの自動生成をスキップ
      g.assets false           # JavaScriptやCSSファイルの自動生成を無効化
      g.helper false           # ヘルパーファイルの自動生成を無効化
      g.test_framework false   # テストファイルの自動生成を無効化
    end

    # 利用可能なロケールを指定
    config.i18n.available_locales = %i[ja en]
    # デフォルトのlocaleを日本語(:ja)にする設定
    config.i18n.default_locale = :ja
    # 下記を記述することによって、複数のローケルファイルが読み込まれる
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
  end
end
