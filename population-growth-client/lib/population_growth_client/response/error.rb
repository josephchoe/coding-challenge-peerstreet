module PopulationGrowthClient
  class Error < ::StandardError
    attr_reader :message

    def initialize(params)
      @message = params[:message]
    end
  end
end
