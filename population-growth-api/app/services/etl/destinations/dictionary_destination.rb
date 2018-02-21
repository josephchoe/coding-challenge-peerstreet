module ETL
  module Destinations
    class DictionaryDestination
      def initialize(options)
        @hash = options[:hash] || []
        @key_column = options[:key_column]
        @conditional_if = options[:if]
      end

      def write(row)
        unless @conditional_if.nil?
          return unless @conditional_if.call(row)
        end
        @hash[row[@key_column].to_sym] = row
      end
    end
  end
end
