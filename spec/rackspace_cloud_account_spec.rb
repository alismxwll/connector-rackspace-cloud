require 'spec_helper'

describe 'rackspace_cloud' do

  before(:all) do
    @api_key  = 'http://docs.rackspace.com/cm/api/v1.0/cm-devguide/content/general-api-info-authentication.html'
    @username = 'rackspace_username'
  end
  describe 'limits' do
    it 'can authenticate' do
      service_instance = service_instance('rackspace_cloud')
      params = {
        'api_key'  => @api_key,
        'username' => @username
      }
      service_instance.test_action('limits', params) do
        expect_return
      end
    end
  end
end
