# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Helplog::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || '60d30dfb7b4c38caeae58229eb87922612b4a58a16f9d3d9b38a534c3d020dbc4a823d388e932031a01e40f6caa1f742b8f3b88c5d5b5acfdce2900f54d9b880'
