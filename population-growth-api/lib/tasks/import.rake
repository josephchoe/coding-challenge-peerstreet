require 'aws-sdk'

namespace :import do
  desc "TODO"
  task census: :environment do
    file_zip_to_cbsa = "#{Rails.root}/tmp/zip_to_cbsa.csv"
    file_cbsa_to_msa = "#{Rails.root}/tmp/cbsa_to_msa.csv"

    s3 = Aws::S3::Resource.new
    s3.bucket(ENV['IMPORT_BUCKET']).object('zip_to_cbsa.csv').get(response_target: file_zip_to_cbsa)
    s3.bucket(ENV['IMPORT_BUCKET']).object('cbsa_to_msa.csv').get(response_target: file_cbsa_to_msa)

    zip_to_cbsa = import_zip_to_cbsa(file_zip_to_cbsa)
    cbsa_to_msa, msa = import_cbsa_to_msa(file_cbsa_to_msa)

    ETL::ImportCensus.new(
      zip_to_cbsa: zip_to_cbsa,
      cbsa_to_msa: cbsa_to_msa,
      msa: msa
    ).import
  end

  # TODO: Refactor to own class.
  def import_zip_to_cbsa(input_file)
    zip_to_cbsa = {}
    job = Kiba.parse do
      source ETL::Sources::CsvSource, input_file: input_file
      transform ETL::Transforms::ExcludeField, except: [:zip, :cbsa]
      destination ETL::Destinations::KeyMultiValueDestination,
                  hash: zip_to_cbsa,
                  key_column: :zip,
                  value_column: :cbsa
    end
    Kiba.run(job)
    zip_to_cbsa
  end

  # TODO: Refactor to own class.
  def import_cbsa_to_msa(input_file)
    cbsa_to_msa = {}
    msa = {}
    job = Kiba.parse do
      source ETL::Sources::CsvSource, input_file: input_file
      transform { |row| row[:cbsa].nil? ? nil : row }
      transform ETL::Transforms::RenameField,
                from: :popestimate2014,
                to: :population_2014
      transform ETL::Transforms::RenameField,
                from: :popestimate2015,
                to: :population_2015
      transform ETL::Transforms::ExcludeField, except: [
        :cbsa,
        :mdiv,
        :name,
        :lsad,
        :population_2014,
        :population_2015
      ]
      destination ETL::Destinations::KeyMultiValueDestination,
                  hash: cbsa_to_msa,
                  key_column: :mdiv,
                  value_column: :cbsa
      destination ETL::Destinations::DictionaryDestination,
                  hash: msa,
                  key_column: :cbsa,
                  if: -> (row) { row[:lsad] == 'Metropolitan Statistical Area' }
    end
    Kiba.run(job)
    [cbsa_to_msa, msa]
  end
end
