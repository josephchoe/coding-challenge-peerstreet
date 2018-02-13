require 'spec_helper'
require 'population_growth_client/response/error'

RSpec.describe PopulationGrowthClient::Error do
  describe '#message' do
    it 'returns initialized message' do
      error = described_class.new(message: 'Test message')
      expect(error.message).to eql('Test message')
    end
  end
end
