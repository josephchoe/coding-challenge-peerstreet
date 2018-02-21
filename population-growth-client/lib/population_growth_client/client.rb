require 'population_growth_client'
require 'faraday'

module PopulationGrowthClient
  class Client
    ENDPOINT = 'http://production.ei5pmnpwgf.us-east-1.elasticbeanstalk.com'.freeze

    def initialize(options = {})
      self.client_options = options.merge(url: ENDPOINT)
    end

    def get(options = {})
      response = connection.get do |request|
        request.url '/census'
        request.params['zip_code'] = options[:zip_code]
      end

      response.body
    end

    private

    attr_accessor :client_options

    def connection
      @connection ||= Faraday.new(url: client_options[:url]) do |faraday|
        faraday.use ::PopulationGrowthClient::ParsePopulation
        faraday.use ::PopulationGrowthClient::ParseError
        faraday.use ::PopulationGrowthClient::ParseJson
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
