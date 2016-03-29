module OmniAuth
  module Strategies
    # tell OmniAuth to load our strategy
    autoload :MicroOAuth2, Rails.root.join('lib', 'strategies', 'micro_oauth2')
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :MicroOAuth2, Rails.application.secrets.oauth_client_id, Rails.application.secrets.oauth_client_secret
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret
  provider :reddit, Rails.application.secrets.reddit_client_id, Rails.application.secrets.reddit_client_secret, :scope => 'account'
end

#OmniAuth.config.on_failure do |env|
#  error_type = env['omniauth.error.type']
#  new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{error_type}"
#  [301, {'Location' => new_path, 'Content-Type' => 'text/html'}, []]
#end
