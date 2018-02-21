module ETL
  module Transforms
    class RenameField
      def initialize(from:, to:)
        @from = from
        @to = to
      end

      def process(row)
        row.tap { row[@to] = row.delete(@from) }
      end
    end
  end
end
