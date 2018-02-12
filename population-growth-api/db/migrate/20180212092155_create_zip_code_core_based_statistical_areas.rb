class CreateZipCodeCoreBasedStatisticalAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :zip_code_core_based_statistical_areas do |t|
      t.integer :zip_code_id, null: false
      t.integer :core_based_statistical_area_id, null: false
      t.timestamps
    end

    add_foreign_key :zip_code_core_based_statistical_areas, :zip_codes
    add_foreign_key :zip_code_core_based_statistical_areas, :core_based_statistical_areas
  end
end
