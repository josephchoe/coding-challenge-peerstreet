require 'rails_helper'

RSpec.describe CoreBasedStatisticalArea, type: :model do
  it { is_expected.to have_one(:metropolitan_statistical_area) }
  it { is_expected.to validate_presence_of(:cbsa) }
  it do
    is_expected.to allow_values('00000', '00001', '10000', '99999')
      .for(:cbsa).with_message('not a valid zip code')
  end

  it do
    is_expected.not_to allow_values('0', '000001', 'test')
      .for(:cbsa).with_message('not a valid cbsa')
  end
end
