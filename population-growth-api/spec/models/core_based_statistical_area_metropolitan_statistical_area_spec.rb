require 'rails_helper'

RSpec.describe CoreBasedStatisticalAreaMetropolitanStatisticalArea, type: :model do
  it { is_expected.to belong_to(:core_based_statistical_area) }
  it { is_expected.to belong_to(:metropolitan_statistical_area) }
end
