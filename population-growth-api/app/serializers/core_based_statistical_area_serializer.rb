class CoreBasedStatisticalAreaSerializer < ActiveModel::Serializer
  attributes :zip_code,
             :cbsa,
             :msa,
             :population_2014,
             :population_2015

  def zip_code
    instance_options[:zip_code]
  end

  def msa
    object.metropolitan_statistical_area&.name
  end

  def population_2014
    object.metropolitan_statistical_area&.population_2014
  end

  def population_2015
    object.metropolitan_statistical_area&.population_2015
  end
end
