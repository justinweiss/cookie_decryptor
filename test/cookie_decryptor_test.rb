require 'test_helper'

class CookieDecryptorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CookieDecryptor::VERSION
  end

  def test_can_decrypt_a_cookie
    decrypted_data = CookieDecryptor.decrypt("OXJ2SkhNaFZBWDd1eDU3djhSekZRdmN6WjNKUjN4dlBiMWt3bW9sVjM0OERIZ3lPUmV1UFB2MmlySzI0OXJtbTRDdmI3TGd0S3AvMVNjdTlueEo1Y05zMnE3NTdsMVVmWWFVSXA5NVFOT0U9LS1tM21SL2tIMGhxYjFEWjZjb2Y3ZWlnPT0%3D--533f89e5525959c122e31ff7eae5b886b2ed7fe9", secret_key_base: "1c81d82d9be8b21667f16b254da480cbbd0fd9fdf856ea88a285479e1bec9860cb3fdda0b214a25e34b16d83929ae87ec846648c7ef5cef35121f029c341ad7b")

    assert_equal(
      '{"session_id":"35481e34ef3c0d0ac83e4dccf8520120","name":"Justin"}',
      decrypted_data
    )
  end
end
