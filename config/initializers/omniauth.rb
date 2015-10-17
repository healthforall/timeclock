Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '583710601190-1encd5u3fsunkm3f32ul2nksqhbsdcs9.apps.googleusercontent.com', '2jHT1qF3S_Hg1Ys9ERd4LK2_',
           {
               scope: 'email',
               access_type: 'offline'
           }

end