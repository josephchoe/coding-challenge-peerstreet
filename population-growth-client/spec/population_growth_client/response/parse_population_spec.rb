require 'spec_helper'

RSpec.describe PopulationGrowthClient::ParsePopulation do
  context 'when response status is 200' do
    it 'returns PopulationGrowthClient::Response' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/census') do
          [
            200,
            {},
            [
              {
                zip_code: '00001',
                cbsa: '10000',
                msa: 'Test',
                population_2014: 100,
                population_2015: 100
              }
            ]
          ]
        end
      end

      connection = Faraday.new(url: 'http://test') do |builder|
        builder.use described_class
        builder.adapter(:test, stubs)
      end

      response = connection.get('/census')

      expect(response.body.first).to have_attributes(
        zip_code: '00001',
        cbsa: '10000',
        msa: 'Test',
        population_2014: 100,
        population_2015: 100
      )
      stubs.verify_stubbed_calls
    end
  end

  context 'when response status is 400' do
    it 'does not parse body' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/census') { [400, {}, 'test'] }
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
end
