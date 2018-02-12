module ETL
  class ImportCensus
    def initialize(zip_to_cbsa:, cbsa_to_msa:, msa:)
      self.zip_to_cbsa = zip_to_cbsa
      self.cbsa_to_msa = cbsa_to_msa
      self.msa = msa
    end

    def import
      zip_to_cbsa.each do |zip, cbsa_array|
        zip_code = ZipCode.find_or_create_by(zip_code: zip)

        cbsa_array.each do |cbsa|
          alternate_cbsa = cbsa_to_msa[cbsa.to_sym]
          true_cbsa = alternate_cbsa.nil? ? cbsa : alternate_cbsa.first

          cbsa_record = CoreBasedStatisticalArea.find_or_create_by(cbsa: cbsa)
          ZipCodeCoreBasedStatisticalArea.find_or_create_by(
            zip_code: zip_code,
            core_based_statistical_area: cbsa_record
          )
          metro_row = msa[true_cbsa.to_sym]
          next if metro_row.nil?
          name = metro_row[:name]
          population_2014 = metro_row[:population_2014]
          population_2015 = metro_row[:population_2015]
          metro_area = MetropolitanStatisticalArea.find_or_create_by(
            name: name,
            population_2014: population_2014,
            population_2015: population_2015
          )
          CoreBasedStatisticalAreaMetropolitanStatisticalArea.find_or_create_by(
            core_based_statistical_area: cbsa_record,
            metropolitan_statistical_area: metro_area
          )
        end
      end
    end

    private

    attr_accessor :zip_to_cbsa,
                  :cbsa_to_msa,
                  :msa
  end
end
