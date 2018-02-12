class CoreBasedStatisticalArea < ApplicationRecord
  has_many :core_based_statistical_area_metropolitan_statistical_areas
  has_many :metropolitan_statistical_areas, through: :core_based_statistical_area_metropolitan_statistical_areas

  validates :cbsa,
            presence: true,
            format: {
              with: /\A\d{5}\z/,
              message: 'not a valid cbsa',
              allow_nil: true
            }
end
