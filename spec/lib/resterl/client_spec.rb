require_relative '../../spec_helper'

require 'webmock/rspec'
require 'timecop'

describe Resterl::Client do
  describe 'minimum cache lifetime' do
    before do
      Timecop.freeze(Time.parse('2015-01-01 01:00'))

      stub_request(:get, 'http://www.example.com/').to_return(
        status: 200,
        body: 'hello world',
        headers: { cache_control: 'max-age=0, private, must-revalidate' }
      ).then.to_raise('2 requests')
    end
    let(:client) { Resterl::Client.new }

    it 'is used in "max-age=0" case' do
      response = client.get 'http://www.example.com/', {}, {}
      expect(response.expires_at).to eq Time.parse('2015-01-01 01:05')
    end

    it 'uses the caches' do
      client.get 'http://www.example.com/', {}, {}

      Timecop.freeze(Time.parse('2015-01-01 01:00:10'))

      expect do
        client.get 'http://www.example.com/', {}, {}
      end.not_to raise_error
    end
  end
end
