require 'rails_helper'

RSpec.describe ETL::Sources::CsvSource do
  describe '#each' do
    it 'parses to hash' do
      service = described_class.new(input_file: file_fixture('test.csv'))
      service.each do |row|
        expect(row).to eql(column1: 'test1', column2: 'test2')
      end
    end

    context 'when file contains invalid utf' do
      it 'parses to hash' do
        service = described_class.new(input_file: file_fixture('invalid_utf.csv'))
        service.each do |row|
          expect(row).to eql(column1: "\u0093test1\u0094", column2: 'test2')
        end
      end
    end
  end
end
