require 'csv'

module ETL
  module Sources
    class CsvSource
      attr_reader :input_file

      def initialize(options)
        @input_file = options[:input_file]
      end

      def each
        csv_file = File.open(input_file)
        csv_string = csv_file.read.encode!('UTF-8', 'iso-8859-1', invalid: :replace)
        csv = CSV.parse(csv_string, headers: true, header_converters: :symbol)
        csv.each do |row|
          yield(row.to_hash)
        end
      end
    end
  end
end
