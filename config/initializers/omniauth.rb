Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
           {
               scope: ['email',
                       'https://www.googleapis.com/auth/gmail.send'
                      ],
               access_type: 'offline'
           }
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           :scope=> 'email',
           :info_fields=> 'name,email'


end