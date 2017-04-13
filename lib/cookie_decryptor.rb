require "cookie_decryptor/version"

module CookieDecryptor
  autoload :Decryptor, "cookie_decryptor/decryptor"

  # Decrypt <tt>cookie</tt>. If you're inside a Rails app, and
  # <tt>secret_key_base</tt> isn't set, it will decrypt the cookie
  # using your Rails settings. Otherwise, CookieDecryptor will use
  # <tt>secret_key_base</tt> to decrypt the cookie.
  def self.decrypt(cookie, secret_key_base: nil)
    Decryptor.new(cookie, secret_key_base: secret_key_base).decrypt
  end
end
