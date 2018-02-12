require 'rails_helper'

RSpec.describe ETL::RenameField do
  describe '#process' do
    it 'renames field' do
      service = described_class.new(from: :column, to: :new_column)
      row = { column: 'test' }
      expect(service.process(row)).to eql(new_column: 'test')
    end
  end
end
