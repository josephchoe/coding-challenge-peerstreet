require 'csv'

module ETL
  class CsvSource
    attr_reader :input_file

    def initialize(options)
      @input_file = options[:input_file]
    end

    def each
      csv_file = File.read(input_file)
      csv = CSV.parse(csv_file, headers: true, header_converters: :symbol)
      csv.each do |row|
        yield(row.to_hash)
      end
    end
  end
end
