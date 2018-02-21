module PopulationGrowthClient
  class ParsePopulation < Faraday::Middleware
    def call(environment)
      @app.call(environment).on_complete do |env|
        status = env.status

        if status == 200
          env.body = env.body.map { |x| ::PopulationGrowthClient::Response.new(x) }
        end
      end
    end
  end
end
