require 'rails_helper'

RSpec.describe ETL::ImportCensus do
  describe '#import' do
    it 'creates zip code' do
      service = build_normal_service
      expect { service.import }
        .to change(
          ZipCode.where(zip_code: '10000'), :count
        ).by(1)
    end

    it 'creates core based statistical area' do
      service = build_normal_service
      expect { service.import }
        .to change(
          CoreBasedStatisticalArea.where(cbsa: '20000'), :count
        ).by(1)
    end

    it 'creates metropolitan statistical area' do
      service = build_normal_service
      expect { service.import }
        .to change(
          MetropolitanStatisticalArea.where(name: 'Test'), :count
        ).by(1)
    end

    it 'creates zip code mapped to core based statistical area' do
      service = build_normal_service
      zip_code = create(:zip_code)
      cbsa = create(:core_based_statistical_area)
      expect { service.import }
        .to change(
          ZipCodeCoreBasedStatisticalArea.where(
            zip_code_id: zip_code.id,
            core_based_statistical_area_id: cbsa.id
          ), :count
        ).by(1)
    end

    it 'creates core based statistical area mapped to metropolitan statistical area' do
      service = build_normal_service
      cbsa = create(:core_based_statistical_area)
      msa = create(:metropolitan_statistical_area)
      expect { service.import }
        .to change(
          CoreBasedStatisticalAreaMetropolitanStatisticalArea.where(
            core_based_statistical_area_id: cbsa.id,
            metropolitan_statistical_area: msa.id
          ), :count
        ).by(1)
    end

    context 'when cbsa has no msa' do
      it 'creates zip code' do
        service = build_no_msa_service
        expect { service.import }
          .to change(
            ZipCode.where(zip_code: '10000'), :count
          ).by(1)
      end

      it 'creates core based statistical area' do
        service = build_no_msa_service
        expect { service.import }
          .to change(
            CoreBasedStatisticalArea.where(cbsa: '20000'), :count
          ).by(1)
      end

      it 'does not create metropolitan statistical area' do
        service = build_no_msa_service
        expect { service.import }
          .not_to change(
            MetropolitanStatisticalArea.where(name: 'Test'), :count
          )
      end

      it 'creates zip code mapped to core based statistical area' do
        service = build_no_msa_service
        zip_code = create(:zip_code)
        cbsa = create(:core_based_statistical_area)
        expect { service.import }
          .to change(
            ZipCodeCoreBasedStatisticalArea.where(
              zip_code_id: zip_code.id,
              core_based_statistical_area_id: cbsa.id
            ), :count
          ).by(1)
      end

      it 'does not create core based statistical area mapped to metropolitan statistical area' do
        service = build_no_msa_service
        cbsa = create(:core_based_statistical_area)
        expect { service.import }
          .not_to change(
            CoreBasedStatisticalAreaMetropolitanStatisticalArea.where(
              core_based_statistical_area_id: cbsa.id
            ), :count
          )
      end
    end

    context 'when has alternate cbsa' do
      it 'creates zip code' do
        service = build_alternate_cbsa_service
        expect { service.import }
          .to change(
            ZipCode.where(zip_code: '10000'), :count
          ).by(1)
      end

      it 'creates core based statistical area' do
        service = build_alternate_cbsa_service
        expect { service.import }
          .to change(
            CoreBasedStatisticalArea.where(cbsa: '20000'), :count
          ).by(1)
      end

      it 'creates metropolitan statistical area' do
        service = build_alternate_cbsa_service
        expect { service.import }
          .to change(
            MetropolitanStatisticalArea.where(name: 'Test'), :count
          ).by(1)
      end

      it 'creates zip code mapped to core based statistical area' do
        service = build_alternate_cbsa_service
        zip_code = create(:zip_code)
        cbsa = create(:core_based_statistical_area)
        expect { service.import }
          .to change(
            ZipCodeCoreBasedStatisticalArea.where(
              zip_code_id: zip_code.id,
              core_based_statistical_area_id: cbsa.id
            ), :count
          ).by(1)
      end

      it 'creates core based statistical area mapped to metropolitan statistical area' do
        service = build_alternate_cbsa_service
        cbsa = create(:core_based_statistical_area)
        msa = create(:metropolitan_statistical_area)
        expect { service.import }
          .to change(
            CoreBasedStatisticalAreaMetropolitanStatisticalArea.where(
              core_based_statistical_area_id: cbsa.id,
              metropolitan_statistical_area: msa.id
            ), :count
          ).by(1)
      end
    end
  end

  def build_zip_to_cbsa(cbsa: '20000')
    {
      '10000': [cbsa]
    }
  end

  def build_cbsa_to_msa(mdiv: '10001')
    {
      "#{mdiv}": ['20000']
    }
  end

  def build_msa(mdiv: nil)
    {
      '20000': {
        cbsa: '20000',
        mdiv: mdiv,
        name: 'Test',
        lsad: 'Test',
        population_2014: 100,
        population_2015: 100
      }
    }
  end

  def build_service(
    zip_to_cbsa:,
    cbsa_to_msa:,
    msa:
  )
    described_class.new(
      zip_to_cbsa: zip_to_cbsa,
      cbsa_to_msa: cbsa_to_msa,
      msa: msa
    )
  end

  def build_normal_service
    build_service(
      zip_to_cbsa: build_zip_to_cbsa,
      cbsa_to_msa: {},
      msa: build_msa
    )
  end

  def build_no_msa_service
    build_service(
      zip_to_cbsa: build_zip_to_cbsa,
      cbsa_to_msa: {},
      msa: {}
    )
  end

  def build_alternate_cbsa_service
    build_service(
      zip_to_cbsa: build_zip_to_cbsa(cbsa: '10001'),
      cbsa_to_msa: build_cbsa_to_msa,
      msa: build_msa(mdiv: '10001')
    )
  end
end
