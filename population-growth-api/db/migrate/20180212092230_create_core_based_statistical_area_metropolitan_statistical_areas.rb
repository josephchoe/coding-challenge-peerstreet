class CreateCoreBasedStatisticalAreaMetropolitanStatisticalAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :core_based_statistical_area_metropolitan_statistical_areas do |t|
      t.integer :core_based_statistical_area_id, null: false
      t.integer :metropolitan_statistical_area_id, null: false
      t.timestamps
    end

    add_foreign_key :core_based_statistical_area_metropolitan_statistical_areas, :core_based_statistical_areas
    add_foreign_key :core_based_statistical_area_metropolitan_statistical_areas, :metropolitan_statistical_areas
  end
end
