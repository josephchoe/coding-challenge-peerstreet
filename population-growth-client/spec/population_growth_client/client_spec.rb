require 'spec_helper'
require 'webmock/rspec'

RSpec.describe PopulationGrowthClient::Client do
  it 'calls endpoint' do
    stub_request(:get, "#{PopulationGrowthClient::Client::ENDPOINT}/census?zip_code=00001")
      .to_return(status: 200, headers: { content_type: 'application/json' }, body: '[{ "test": "test" }]')

    PopulationGrowthClient::Client.new.get(zip_code: '00001')

    expect(a_request(:get, "#{PopulationGrowthClient::Client::ENDPOINT}/census?zip_code=00001")
      .with(body: ''))
      .to have_been_made.once
  end
end
