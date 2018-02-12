require 'rails_helper'

RSpec.describe MetropolitanStatisticalArea, type: :model do
  it { is_expected.to belong_to(:core_based_statistical_area) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(100) }
  it { is_expected.to validate_presence_of(:population_2014) }
  it { is_expected.to validate_numericality_of(:population_2014).only_integer }
  it { is_expected.to validate_presence_of(:population_2015) }
  it { is_expected.to validate_numericality_of(:population_2015).only_integer }
end
