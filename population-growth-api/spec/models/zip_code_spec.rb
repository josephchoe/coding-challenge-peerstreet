require 'rails_helper'

RSpec.describe ZipCode, type: :model do
  it { is_expected.to have_many(:zip_code_core_based_statistical_areas) }
  it { is_expected.to have_many(:core_based_statistical_areas).through(:zip_code_core_based_statistical_areas) }
  it { is_expected.to validate_presence_of(:zip_code) }
  it do
    is_expected.to allow_values('00000', '00001', '10000', '99999')
      .for(:zip_code).with_message('not a valid zip code')
  end

  it do
    is_expected.not_to allow_values('0', '000001', 'test')
      .for(:zip_code).with_message('not a valid zip code')
  end
end
