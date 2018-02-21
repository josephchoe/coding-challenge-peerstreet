require 'active_support/core_ext/string'

module PopulationGrowthClient
  class ParseJson < Faraday::Middleware
    def call(environment)
      @app.call(environment).on_complete do |env|
        content_type = env.response_headers['content-type']
        env.body = ::JSON.parse(env.body, symbolize_names: true) if
          env.body.strip.present? &&
          content_type.include?('json')
      end
    end
  end
end
