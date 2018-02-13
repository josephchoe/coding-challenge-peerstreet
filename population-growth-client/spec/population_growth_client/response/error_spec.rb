require 'spec_helper'

RSpec.describe PopulationGrowthClient::Error do
  describe '#message' do
    it 'returns initialized message' do
      error = described_class.new(message: 'Test message')
      expect(error.message).to eql('Test message')
    end
  end
end
