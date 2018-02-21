require 'spec_helper'
require 'json'

RSpec.describe PopulationGrowthClient::ParseJson do
  context 'when content type is json' do
    it 'parses body' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/census') { [200, { content_type: 'application/json' }, '{ "test": "test" }'] }
      end

      connection = Faraday.new(url: 'http://test') do |builder|
        builder.use described_class
        builder.adapter(:test, stubs)
      end

      response = connection.get('/census')

      expect(response.body).to eql(test: 'test')
      stubs.verify_stubbed_calls
    end
  end

  context 'when content type is not json' do
    it 'does not parse body' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/census') { [200, { content_type: 'text/plain' }, 'test'] }
      end

      connection = Faraday.new(url: 'http://test') do |builder|
        builder.use described_class
        builder.adapter(:test, stubs)
      end

      response = connection.get('/census')

      expect(response.body).to eql('test')
      stubs.verify_stubbed_calls
    end
  end
  context 'when empty body' do
    it 'does not parse' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/census') { [200, { content_type: 'application/json' }, ''] }
      end

      connection = Faraday.new(url: 'http://test') do |builder|
        builder.use described_class
        builder.adapter(:test, stubs)
      end

      expect { connection.get('/census') }.not_to raise_error
      stubs.verify_stubbed_calls
    end
  end
end
