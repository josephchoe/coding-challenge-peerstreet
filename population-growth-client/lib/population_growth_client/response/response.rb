module PopulationGrowthClient
  class Response
    attr_reader :zip_code,
                :cbsa,
                :msa,
                :population_2014,
                :population_2015

    def initialize(params)
      @zip_code = params[:zip_code]
      @cbsa = params[:cbsa]
      @msa = params[:msa]
      @population_2014 = params[:population_2014]
      @population_2015 = params[:population_2015]
    end
  end
end
