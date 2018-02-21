class CensusController < ApplicationController
  before_action :filter_bad_request

  def index
    zip_code = ZipCode.find_by_zip_code(param_zip_code)
    cbsa = zip_code&.core_based_statistical_areas
    if cbsa.nil?
      render json: render_empty_record, status: :ok
    else
      render json: zip_code&.core_based_statistical_areas,
             status: :ok,
             zip_code: param_zip_code
    end
  end

  private

  def filter_bad_request
    render_error(:bad_request, '\'zip_code\' parameter must be five digits') unless /\A\d{5}\z/ =~ param_zip_code
  rescue ActionController::ParameterMissing
    render_error(:bad_request, 'requires \'zip_code\' parameter')
  end

  def render_empty_record
    [
      {
        zip_code: param_zip_code,
        cbsa: '99999',
        msa: nil,
        population_2014: nil,
        population_2015: nil
      }
    ]
  end

  def param_zip_code
    params.require(:zip_code)
  end
end
