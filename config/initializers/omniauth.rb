Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["51200442618-jr20h17vmd5cc69gomiuisl84mnkj9nr.apps.googleusercontent.com"], ENV["hOdxdYUK3aJ0aTgC2alGPuNa"],
           {
               :scope => 'email,profile',
               :prompt => 'select_account'
           }

end