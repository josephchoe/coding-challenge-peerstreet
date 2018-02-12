class ZipCode < ApplicationRecord
  has_many :zip_code_core_based_statistical_areas
  has_many :core_based_statistical_areas, through: :zip_code_core_based_statistical_areas
  has_many :core_based_statistical_area_metropolitan_statistical_areas, through: :core_based_statistical_areas
  has_many :metropolitan_statistical_areas, through: :core_based_statistical_area_metropolitan_statistical_areas

  validates :zip_code,
            presence: true,
            format: {
              with: /\A\d{5}\z/,
              message: 'not a valid zip code',
              allow_nil: true
            }
end
