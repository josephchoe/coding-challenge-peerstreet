class MetropolitanStatisticalArea < ApplicationRecord
  belongs_to :core_based_statistical_area

  validates :name,
            presence: true,
            length: { maximum: 100 }
  validates :population_2014,
            presence: true,
            numericality: { only_integer: true }
  validates :population_2015,
            presence: true,
            numericality: { only_integer: true }
end
