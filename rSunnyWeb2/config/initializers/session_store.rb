# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rSunnyWeb2_session',
  :secret      => 'd3fbf9c414e5a0a31e509b95fb82f7c47e93521fa6e217e57ac31df0f73db21a74001099dfc5ae0167db3ccc32b37847bb7bfcf15f30ee0f10585ac4f559eb5f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
