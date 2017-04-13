# CookieDecryptor

When you're trying to debug cookie session problems, are you stuck with cookies that look like this?

```
Set-Cookie: _session_my_app=OXJ2SkhNaFZBWDd1eDU3djhSekZRdmN6WjNKUjN4dlBiMWt3bW9sVjM0OERIZ3lPUmV1UFB2MmlySzI0OXJtbTRDdmI3TGd0S3AvMVNjdTlueEo1Y05zMnE3NTdsMVVmWWFVSXA5NVFOT0U9LS1tM21SL2tIMGhxYjFEWjZjb2Y3ZWlnPT0%3D--533f89e5525959c122e31ff7eae5b886b2ed7fe9; path=/; HttpOnly
```

What does that even mean? How do you figure out that that cookie decodes to 

```json
{"session_id":"35481e34ef3c0d0ac83e4dccf8520120","name":"Justin"}
```

without faking the session yourself?

With CookieDecryptor, you can paste that header in and get the result right back out.

```ruby
irb(main):001:0> CookieDecryptor.decrypt("Set-Cookie: _session_my_app=OXJ2SkhNaFZBWDd1eDU3djhSekZRdmN6WjNKUjN4dlBiMWt3bW9sVjM0OERIZ3lPUmV1UFB2MmlySzI0OXJtbTRDdmI3TGd0S3AvMVNjdTlueEo1Y05zMnE3NTdsMVVmWWFVSXA5NVFOT0U9LS1tM21SL2tIMGhxYjFEWjZjb2Y3ZWlnPT0%3D--533f89e5525959c122e31ff7eae5b886b2ed7fe9; path=/; HttpOnly")
=> "{\"session_id\":\"35481e34ef3c0d0ac83e4dccf8520120\",\"name\":\"Justin\"}"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cookie_decryptor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cookie_decryptor

## Usage

You can decrypt cookie data with `CookieDecryptor.decrypt`:

```ruby
CookieDecryptor.decrypt("OXJ2SkhNaFZBWDd1eDU3djhSekZRdmN6WjNKUjN4dlBiMWt3bW9sVjM0OERIZ3lPUmV1UFB2MmlySzI0OXJtbTRDdmI3TGd0S3AvMVNjdTlueEo1Y05zMnE3NTdsMVVmWWFVSXA5NVFOT0U9LS1tM21SL2tIMGhxYjFEWjZjb2Y3ZWlnPT0%3D--533f89e5525959c122e31ff7eae5b886b2ed7fe9")
```

Or you can be extra lazy, and paste an entire HTTP cookie header:

```ruby
CookieDecryptor.decrypt("Set-Cookie: _session_my_app=OXJ2SkhNaFZBWDd1eDU3djhSekZRdmN6WjNKUjN4dlBiMWt3bW9sVjM0OERIZ3lPUmV1UFB2MmlySzI0OXJtbTRDdmI3TGd0S3AvMVNjdTlueEo1Y05zMnE3NTdsMVVmWWFVSXA5NVFOT0U9LS1tM21SL2tIMGhxYjFEWjZjb2Y3ZWlnPT0%3D--533f89e5525959c122e31ff7eae5b886b2ed7fe9; path=/; HttpOnly")
```

If you're inside your Rails app, CookieDecryptor will default to using your Rails app's `secret_key_base`. If you're not in a Rails app, or if you want to use a different `secret_key_base`, you can specify it: 

```ruby
CookieDecryptor.decrypt("OXJ2SkhNaFZBWDd1eDU3djhSekZRdmN6WjNKUjN4dlBiMWt3bW9sVjM0OERIZ3lPUmV1UFB2MmlySzI0OXJtbTRDdmI3TGd0S3AvMVNjdTlueEo1Y05zMnE3NTdsMVVmWWFVSXA5NVFOT0U9LS1tM21SL2tIMGhxYjFEWjZjb2Y3ZWlnPT0%3D--533f89e5525959c122e31ff7eae5b886b2ed7fe9", secret_key_base: "1c81d82d9be8b21667f16b254da480cbbd0fd9fdf856ea88a285479e1bec9860cb3fdda0b214a25e34b16d83929ae87ec846648c7ef5cef35121f029c341ad7b")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/justinweiss/cookie_decryptor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

