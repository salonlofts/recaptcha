module Recaptcha
  # This class enables detailed configuration of the recaptcha services.
  #
  # By calling
  #
  #   Recaptcha.configuration # => instance of Recaptcha::Configuration
  #
  # or
  #   Recaptcha.configure do |config|
  #     config # => instance of Recaptcha::Configuration
  #   end
  #
  # you are able to perform configuration updates.
  #
  # Your are able to customize all attributes listed below. All values have
  # sensitive default and will very likely not need to be changed.
  #
  # Please note that the site and secret key for the reCAPTCHA API Access
  # have no useful default value. The keys may be set via the Shell enviroment
  # or using this configuration. Settings within this configuration always take
  # precedence.
  #
  # Setting the keys with this Configuration
  #
  #   Recaptcha.configure do |config|
  #     config.site_key  = '6Lc6BAAAAAAAAChqRbQZcn_yyyyyyyyyyyyyyyyy'
  #     config.secret_key = '6Lc6BAAAAAAAAKN3DRm6VA_xxxxxxxxxxxxxxxxx'
  #   end
  #
  class Configuration
    attr_accessor :skip_verify_env, :secret_key, :site_key, :api_server_url, :verify_url, :proxy,
      :handle_timeouts_gracefully, :hostname

    def initialize #:nodoc:
      @skip_verify_env            = %w[test cucumber]
      @handle_timeouts_gracefully = HANDLE_TIMEOUTS_GRACEFULLY

      @secret_key           = ENV['RECAPTCHA_SECRET_KEY']
      @site_key             = ENV['RECAPTCHA_SITE_KEY']

      @api_server_url       = ENV['RECAPTCHA_API_SERVER_URL']
      @verify_url           = ENV['RECAPTCHA_VERIFY_URL']
    end

    def secret_key!
      secret_key || raise(RecaptchaError, "No secret key specified.")
    end

    def site_key!
      site_key || raise(RecaptchaError, "No site key specified.")
    end

    def api_server_url
      @api_server_url || CONFIG.fetch('server_url')
    end

    def verify_url
      @verify_url || CONFIG.fetch('verify_url')
    end
  end
end
