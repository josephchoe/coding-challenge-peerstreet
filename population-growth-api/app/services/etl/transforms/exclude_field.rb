module ETL
  module Transforms
    class ExcludeField
      def initialize(except:)
        @except = except
      end

      def process(row)
        row.slice(*@except)
      end
    end
  end
end
