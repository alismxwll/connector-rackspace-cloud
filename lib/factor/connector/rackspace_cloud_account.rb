require 'factor-connector-api'
require 'rest_client'
require 'nori'

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
      xml_response = RestClient.post uri, JSON.dump(payload), header
      parsed       = Nori.new.parse(xml_response)
      @token_id    = parsed['access']['token']['@id'] #THIS MAY BE WRONG =D ['access']['tenent']['@id']
    rescue => ex
      fail "A problem occured, #{ex}"
    end

    info 'Grabbing account info'
    begin
      raw_response = RestClient::Request.execute(url: "https://monitoring.api.rackspacecloud.com/v1.0/#{THIS MAY BE WRONG =D}", method: 'GET', ssl_version: 'SSLv23')
      puts "raw_response: #{raw_response}"
    rescue => ex
      fail "A problem occured, #{ex}"
    end

    action_callback raw_response
  end
end
