# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_riclife_session',
  :secret      => 'd623a19d44b1e78c8af1a7e81e810b3de4994c4ffb611f9444579e6ac3d65496c541b6e7be91fd93bb2ef11e4db7acaf44b22484a5cffdb13e9329c8dd20f437'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
