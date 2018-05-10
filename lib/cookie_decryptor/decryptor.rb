require 'active_support'
require 'cgi'

module CookieDecryptor
  # Decrypts a Rails cookie, using ActiveSupport::KeyGenerator and
  # ActiveSupport::MessageVerifier. If this code is running inside a
  # Rails app, it will use the key generator and secrets the Rails app
  # is using. Otherwise, you must pass in your app's
  # <tt>secret_key_base</tt>, and we will use hardcoded key strings
  # from Rails.
  class Decryptor

    def initialize(cookie, secret_key_base: nil)
      @cookie = CGI.unescape(extract_cookie(cookie))
      @key_generator = key_generator(secret_key_base)
    end

    # Returns the decrypted data inside <tt>cookie</tt>.
    def decrypt
      encryptor.decrypt_and_verify(@cookie)
    end

    private

    # Extract cookie data out of a complete cookie header: everything
    # after the first = and before the first ;
    def extract_cookie(cookie)
      cookie.sub(/[^=]*=/, "").split(";").first
    end

    def key_generator(secret_key_base)
      if secret_key_base
        ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
      elsif defined?(Rails.application)
        Rails.application.key_generator
      else
        raise ArgumentError, "You must specify a secret_key_base in order to decrypt sessions."
      end
    end

    def encryptor
      secret = @key_generator.generate_key("encrypted cookie")[0, ActiveSupport::MessageEncryptor.key_len]
      sign_secret = @key_generator.generate_key("signed encrypted cookie")
      ActiveSupport::MessageEncryptor.new(
        secret,
        sign_secret,
        serializer: ActiveSupport::MessageEncryptor::NullSerializer
      )
    end
  end
end
