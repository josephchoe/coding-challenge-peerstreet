class ZipCodeCoreBasedStatisticalArea < ApplicationRecord
  belongs_to :zip_code
  belongs_to :core_based_statistical_area
end
