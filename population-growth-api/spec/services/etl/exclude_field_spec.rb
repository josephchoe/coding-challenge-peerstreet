require 'rails_helper'

RSpec.describe ETL::ExcludeField do
  describe '#process' do
    it 'excludes all fields except given keys' do
      service = described_class.new(except: [:column1, :column2])
      row = {
        column1: 'test1',
        column2: 'test2',
        column3: 'test3',
        column4: 'test4'
      }
      expect(service.process(row)).to eql(column1: 'test1', column2: 'test2')
    end
  end
end
