require 'rails_helper'

RSpec.describe ETL::Destinations::KeyMultiValueDestination do
  describe '#write' do
    it 'adds to hash' do
      hash = {}
      service = described_class.new(hash: hash,
                                    key_column: :column1,
                                    value_column: :column2)
      service.write(column1: 'test1',
                    column2: 'test2')
      expect(hash).to match_array(test1: ['test2'])
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

    context 'if another value already exists' do
      it 'adds to hash' do
        hash = {}
        service = described_class.new(hash: hash,
                                      key_column: :column1,
                                      value_column: :column2)
        service.write(column1: 'test1',
                      column2: 1)
        service.write(column1: 'test1',
                      column2: 3)
        expect(hash).to match_array(test1: [1, 3])
      end
    end

    context 'if same value already exists' do
      it 'does not add to hash' do
        hash = {}
        service = described_class.new(hash: hash,
                                      key_column: :column1,
                                      value_column: :column2)
        service.write(column1: 'test1',
                      column2: 1)
        service.write(column1: 'test1',
                      column2: 1)
        expect(hash).to match_array(test1: [1])
      end
    end
  end
end
