require 'spec_helper'

RSpec.describe PopulationGrowthClient::ParseError do
  context 'when no error returned' do
    it 'does not raise Error' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/census') { [200, {}, 'Test'] }
      end

      connection = Faraday.new(url: 'http://test') do |builder|
        builder.use described_class
        builder.adapter(:test, stubs)
      end

      expect { connection.get('/census') }.not_to raise_error
      stubs.verify_stubbed_calls
    end
  end

  context 'when error returned' do
    it 'raises Error' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/census') { [400, {}, errors: [{ message: 'Test error' }]] }
      end

      connection = Faraday.new(url: 'http://test') do |builder|
        builder.use described_class
        builder.adapter(:test, stubs)
      end

      expect { connection.get('/census') }
        .to raise_error(PopulationGrowthClient::Error) do |ex|
          expect(ex.message).to eql 'Test error'
        end
      stubs.verify_stubbed_calls
    end
  end

  context 'when unexpected error returned' do
    it 'raises Error' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/census') { [500, {}, 'Test error'] }
      end

      connection = Faraday.new(url: 'http://test') do |builder|
        builder.use described_class
        builder.adapter(:test, stubs)
      end

      expect { connection.get('/census') }
        .to raise_error(PopulationGrowthClient::Error) do |ex|
          expect(ex.message).to eql 'Test error'
        end
      stubs.verify_stubbed_calls
    end
  end
end
