require 'rails_helper'

RSpec.describe ETL::Destinations::DictionaryDestination do
  describe '#write' do
    it 'adds to hash with key' do
      hash = {}
      service = described_class.new(
        hash: hash,
        key_column: :column1
      )
      service.write(column1: 'test1',
                    column2: 'test2')
      expect(hash).to eql(test1: { column1: 'test1', column2: 'test2' })
    end

    context 'when if conditional returns true' do
      it 'adds to hash with key' do
        hash = {}
        service = described_class.new(
          hash: hash,
          key_column: :column1,
          if: -> (_row) { true }
        )
        service.write(column1: 'test1',
                      column2: 'test2')
        expect(hash).to eql(test1: { column1: 'test1', column2: 'test2' })
      end
    end

    context 'when if conditional returns false' do
      it 'does not to hash with key' do
        hash = {}
        service = described_class.new(
          hash: hash,
          key_column: :column1,
          if: -> (_row) { false }
        )
        service.write(column1: 'test1',
                      column2: 'test2')
        expect(hash).to be_empty
      end
    end
  end
end
