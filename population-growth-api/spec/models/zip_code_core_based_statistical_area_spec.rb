require 'rails_helper'

RSpec.describe ZipCodeCoreBasedStatisticalArea, type: :model do
  it { is_expected.to belong_to(:zip_code) }
  it { is_expected.to belong_to(:core_based_statistical_area) }
end
