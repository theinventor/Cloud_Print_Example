Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "893110491171.apps.googleusercontent.com","hBaYoCclmKH7IUgDYYdk4H0v",
    :approval_prompt => 'force', :access_type => 'offline',
    :scope => 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/cloudprint' 
end

# OmniAuth.config.full_host = "http://localhost:3000"

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google, 'domain.com', 'oauth_secret', :scope => 'https://mail.google.com/mail/feed/atom/' 
# end

