require 'rails_helper'

RSpec.describe '/census', type: :request do
  describe 'GET #index' do
    context 'when querying with no records' do
      it 'returns 200 ok response' do
        send_get_query
        expect(response).to have_http_status(:ok)
      end

      it 'renders in JSON' do
        send_get_query
        expect(response.content_type).to eql('application/json')
      end

      it 'returns response' do
        send_get_query
        expect(parse_json(response)).to eql(
          [
            {
              zip_code: '10000',
              cbsa: '99999',
              msa: nil,
              population_2014: nil,
              population_2015: nil
            }
          ]
        )
      end
    end

    context 'when querying with single record' do
      it 'returns 200 ok response' do
        build_one_cbsa_msa
        send_get_query
        expect(response).to have_http_status(:ok)
      end

      it 'renders in JSON' do
        build_one_cbsa_msa
        send_get_query
        expect(response.content_type).to eql('application/json')
      end

      it 'returns response' do
        zip_code, cbsa, msa = build_one_cbsa_msa
        send_get_query
        expect(parse_json(response)).to eql(
          [
            {
              zip_code: zip_code.zip_code,
              cbsa: cbsa.cbsa,
              msa: msa.name,
              population_2014: msa.population_2014,
              population_2015: msa.population_2015
            }
          ]
        )
      end
    end

    context 'when cbsa has no msa' do
      it 'returns 200 ok response' do
        build_cbsa_no_msa
        send_get_query
        expect(response).to have_http_status(:ok)
      end

      it 'renders in JSON' do
        build_cbsa_no_msa
        send_get_query
        expect(response.content_type).to eql('application/json')
      end

      it 'returns response' do
        zip_code, cbsa = build_cbsa_no_msa
        send_get_query
        expect(parse_json(response)).to eql(
          [
            {
              zip_code: zip_code.zip_code,
              cbsa: cbsa.cbsa,
              msa: nil,
              population_2014: nil,
              population_2015: nil
            }
          ]
        )
      end
    end

    context 'when querying with multiple records' do
      it 'returns 200 ok response' do
        build_multiple_cbsa_msa
        send_get_query
        expect(response).to have_http_status(:ok)
      end

      it 'renders in JSON' do
        build_multiple_cbsa_msa
        send_get_query
        expect(response.content_type).to eql('application/json')
      end

      it 'returns response' do
        record1, record2 = build_multiple_cbsa_msa
        send_get_query
        expect(parse_json(response)).to eql(
          [
            {
              zip_code: record1[:zip_code].zip_code,
              cbsa: record1[:cbsa].cbsa,
              msa: record1[:msa].name,
              population_2014: record1[:msa].population_2014,
              population_2015: record1[:msa].population_2015
            },
            {
              zip_code: record2[:zip_code].zip_code,
              cbsa: record2[:cbsa].cbsa,
              msa: record2[:msa].name,
              population_2014: record2[:msa].population_2014,
              population_2015: record2[:msa].population_2015
            }
          ]
        )
      end
    end
  end

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def build_one_cbsa_msa
    zip_code = create(:zip_code)
    cbsa = create(:core_based_statistical_area)
    msa = create(:metropolitan_statistical_area, core_based_statistical_area: cbsa)
    create(
      :zip_code_core_based_statistical_area,
      zip_code: zip_code,
      core_based_statistical_area: cbsa
    )
    [zip_code, cbsa, msa]
  end

  def build_multiple_cbsa_msa
    zip_code = create(:zip_code)
    cbsa1 = create(:core_based_statistical_area)
    cbsa2 = create(:core_based_statistical_area, cbsa: '40000')
    msa1 = create(:metropolitan_statistical_area, core_based_statistical_area: cbsa1)
    msa2 = create(:metropolitan_statistical_area, core_based_statistical_area: cbsa2)
    create(
      :zip_code_core_based_statistical_area,
      zip_code: zip_code,
      core_based_statistical_area: cbsa1
    )
    create(
      :zip_code_core_based_statistical_area,
      zip_code: zip_code,
      core_based_statistical_area: cbsa2
    )
    [
      {
        zip_code: zip_code,
        cbsa: cbsa1,
        msa: msa1
      },
      {
        zip_code: zip_code,
        cbsa: cbsa2,
        msa: msa2
      }
    ]
  end

  def build_cbsa_no_msa
    zip_code = create(:zip_code)
    cbsa = create(:core_based_statistical_area)
    create(
      :zip_code_core_based_statistical_area,
      zip_code: zip_code,
      core_based_statistical_area: cbsa
    )
    [zip_code, cbsa]
  end

  def send_get_query(query_zip_code: '10000')
    url = "/census?zip_code=#{query_zip_code}"
    get url
  end
end
