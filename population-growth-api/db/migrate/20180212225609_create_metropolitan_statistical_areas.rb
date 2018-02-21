class CreateMetropolitanStatisticalAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :metropolitan_statistical_areas do |t|
      t.integer :core_based_statistical_area_id, null: false
      t.string :name, limit: 100, null: false
      t.integer :population_2014, null: false
      t.integer :population_2015, null: false
      t.timestamps
    end

    add_foreign_key :metropolitan_statistical_areas, :core_based_statistical_areas
  end
end
