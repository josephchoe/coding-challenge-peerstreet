module ETL
  module Destinations
    class KeyValueDestination
      attr_reader :input_file

      def initialize(options)
        @hash = options[:hash]
        @key_column = options[:key_column]
        @value_column = options[:value_column]
      end

      def write(row)
        @hash[row[@key_column].to_sym] = row[@value_column] unless
          row[@key_column].nil?
      end
    end
  end
end
