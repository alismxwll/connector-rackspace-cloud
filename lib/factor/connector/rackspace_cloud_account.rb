require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'rackspace_cloud' do
  action 'limits' do |params|
    @api_key  = params['api_key']
    @username = params['username']

    fail 'apiKey must be defined' unless @api_key
    fail 'username must be defined' unless @username

    payload = {
      auth: {
        'RAX-KSKEY:apiKeyCredentials' => {
          username: @username,
          apiKey: @api_key
        }
      }
    }

    header = {
      'Content-Type' => 'application/json'
    }

    info 'Authenticating your request'
    begin
      uri          = "https://identity.api.rackspacecloud.com/v2.0/tokens"
      raw_response = RestClient.post uri, JSON.dump(payload), header
    rescue => ex
      fail "A problem occured #{ex}"
    end

    puts "response #{raw_response}"
    action_callback raw_response
  end
end
