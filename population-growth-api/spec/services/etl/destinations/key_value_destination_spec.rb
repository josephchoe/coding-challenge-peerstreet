require 'rails_helper'

RSpec.describe ETL::Destinations::KeyValueDestination do
  describe '#write' do
    it 'adds to hash' do
      hash = {}
      service = described_class.new(hash: hash,
                                    key_column: :column1,
                                    value_column: :column2)
      service.write(column1: 'test1',
                    column2: 'test2')
      expect(hash).to eql(test1: 'test2')
    end

    context 'if key_column is nil' do
      it 'does not add to hash' do
        hash = {}
        service = described_class.new(hash: hash,
                                      key_column: :column1,
                                      value_column: :column2)
        service.write(column1: nil,
                      column2: 'test2')
        expect(hash).to be_empty
      end
    end
  end
end
