class CoreBasedStatisticalArea < ApplicationRecord
  has_one :metropolitan_statistical_area

  validates :cbsa,
            presence: true,
            format: {
              with: /\A\d{5}\z/,
              message: 'not a valid cbsa',
              allow_nil: true
            }
end
