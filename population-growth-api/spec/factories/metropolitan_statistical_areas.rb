FactoryBot.define do
  factory :metropolitan_statistical_area do
    core_based_statistical_area
    name 'Test'
    population_2014 100
    population_2015 100
  end
end
