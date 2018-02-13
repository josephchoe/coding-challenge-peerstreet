require 'spec_helper'

RSpec.describe PopulationGrowthClient::Response do
  describe '#zip_code' do
    it 'returns initialized zip code' do
      response = described_class.new(zip_code: '00001')
      expect(response.zip_code).to eql('00001')
    end
  end

  describe '#cbsa' do
    it 'returns initialized cbsa' do
      response = described_class.new(cbsa: '00001')
      expect(response.cbsa).to eql('00001')
    end
  end

  describe '#msa' do
    it 'returns initialized msa' do
      response = described_class.new(msa: 'Test MSA')
      expect(response.msa).to eql('Test MSA')
    end
  end

  describe '#population_2014' do
    it 'returns initialized population_2014' do
      response = described_class.new(population_2014: 100)
      expect(response.population_2014).to eql(100)
    end
  end

  describe '#population_2015' do
    it 'returns initialized population_2015' do
      response = described_class.new(population_2015: 100)
      expect(response.population_2015).to eql(100)
    end
  end
end
