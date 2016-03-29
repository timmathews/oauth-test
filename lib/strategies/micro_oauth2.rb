require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MicroOAuth2 < OmniAuth::Strategies::OAuth2
      option :name, :micro_oauth2

      option :client_options, {
        :site => "http://tau.int.8191.net:6060",
        :authorize_url => "/web/authorize",
        :token_url => "/v1/oauth/tokens"
      }

      option :authorize_params, {
        :login_redirect_uri => 'http://localhost:3000/auth/micro_oauth2/callback',
        :scope => 'read_write'
      }

      uid { raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/v1/oauth/introspect').parsed
      end

      def build_access_token
        options.token_params.merge!(:headers => {'Authorization' => basic_auth_header })
        super
      end

      def basic_auth_header
        "Basic " + Base64.strict_encode64("#{options[:client_id]}:#{options[:client_secret]}")
      end
    end
  end
end
