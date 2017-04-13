require 'test_helper'
require 'minitest/mock'
require 'ostruct'

class CookieDecryptor::DecryptorTest < Minitest::Test  
  def test_can_decrypt_a_cookie
    cookie = default_cookie

    assert_equal(
      '{"session_id":"35481e34ef3c0d0ac83e4dccf8520120","name":"Justin"}',
      CookieDecryptor::Decryptor.new(cookie, secret_key_base: secret_key_base).decrypt
    )
  end

  def test_can_decrypt_a_full_cookie_header
    cookie = "Set-Cookie: _session_my_app=#{default_cookie}; path=/; HttpOnly"

    assert_equal(
      '{"session_id":"35481e34ef3c0d0ac83e4dccf8520120","name":"Justin"}',
      CookieDecryptor::Decryptor.new(cookie, secret_key_base: secret_key_base).decrypt
    )
  end

  def test_uses_rails_key_generator_if_rails_loaded
    Object.const_set(:Rails, mock_rails)

    cookie = default_cookie
    key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
    Rails.application.expect(:key_generator, key_generator)
    
    assert_equal(
      '{"session_id":"35481e34ef3c0d0ac83e4dccf8520120","name":"Justin"}',
      CookieDecryptor::Decryptor.new(cookie).decrypt
    )

    assert_mock Rails.application
  ensure
    Object.send(:remove_const, :Rails)
  end

  def test_raises_error_if_secret_key_base_not_set
    cookie = default_cookie

    assert_raises ArgumentError do
      CookieDecryptor::Decryptor.new(cookie).decrypt
    end
  end

  private

  def mock_rails
    Module.new do
      def self.application
        @application ||= Minitest::Mock.new
      end
    end
  end

  def default_cookie
    "OXJ2SkhNaFZBWDd1eDU3djhSekZRdmN6WjNKUjN4dlBiMWt3bW9sVjM0OERIZ3lPUmV1UFB2MmlySzI0OXJtbTRDdmI3TGd0S3AvMVNjdTlueEo1Y05zMnE3NTdsMVVmWWFVSXA5NVFOT0U9LS1tM21SL2tIMGhxYjFEWjZjb2Y3ZWlnPT0%3D--533f89e5525959c122e31ff7eae5b886b2ed7fe9"
  end

  def secret_key_base
    "1c81d82d9be8b21667f16b254da480cbbd0fd9fdf856ea88a285479e1bec9860cb3fdda0b214a25e34b16d83929ae87ec846648c7ef5cef35121f029c341ad7b"
  end
end
