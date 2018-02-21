class CreateCoreBasedStatisticalAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :core_based_statistical_areas do |t|
      t.string :cbsa, limit: 5, null: false
      t.timestamps
    end

    add_index :core_based_statistical_areas, :cbsa
  end
end
