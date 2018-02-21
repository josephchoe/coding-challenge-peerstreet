module ETL
  module Destinations
    class KeyMultiValueDestination
      attr_reader :input_file

      def initialize(options)
        @hash = options[:hash] || {}
        @key_column = options[:key_column]
        @value_column = options[:value_column]
      end

      def write(row)
        return if row[@key_column].nil?
        key = row[@key_column].to_sym
        value = row[@value_column]
        @hash[key] << value unless @hash[key].nil? || @hash[key].include?(value)
        @hash[key] = [value] if @hash[key].nil?
      end
    end
  end
end
