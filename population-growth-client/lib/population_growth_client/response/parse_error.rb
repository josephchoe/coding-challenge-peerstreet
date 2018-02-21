module PopulationGrowthClient
  class ParseError < Faraday::Middleware
    def call(environment)
      @app.call(environment).on_complete do |env|
        status = env.status
        body = env.body

        case status
        when 500...599
          raise ::PopulationGrowthClient::Error.new(message: body), status
        when 400...499
          error = body[:errors].first
          raise ::PopulationGrowthClient::Error.new(error), error[:message]
        end
      end
    end
  end
end
