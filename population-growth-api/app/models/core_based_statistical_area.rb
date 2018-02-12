class CoreBasedStatisticalArea < ApplicationRecord
  validates :cbsa,
            presence: true,
            format: {
              with: /\A\d{5}\z/,
              message: 'not a valid cbsa',
              allow_nil: true
            }
end
