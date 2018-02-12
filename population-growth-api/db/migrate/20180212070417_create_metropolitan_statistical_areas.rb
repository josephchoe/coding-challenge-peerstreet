class CreateMetropolitanStatisticalAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :metropolitan_statistical_areas do |t|
      t.string :name, limit: 100, null: false
      t.integer :population_2014, null: false
      t.integer :population_2015, null: false
      t.timestamps
    end
  end
end
