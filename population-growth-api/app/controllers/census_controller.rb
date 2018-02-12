class CensusController < ApplicationController
  def index
    zip_code = ZipCode.find_by_zip_code(param_zip_code)
    cbsa = zip_code&.core_based_statistical_areas
    if cbsa.nil?
      render json: [
          {
            zip_code: param_zip_code,
            cbsa: '99999',
            msa: nil,
            population_2014: nil,
            population_2015: nil
          }
        ], status: :ok
    else
      render json: zip_code&.core_based_statistical_areas,
             status: :ok,
             zip_code: param_zip_code
    end
  end

  private

  def param_zip_code
    params.require(:zip_code)
  end
end
