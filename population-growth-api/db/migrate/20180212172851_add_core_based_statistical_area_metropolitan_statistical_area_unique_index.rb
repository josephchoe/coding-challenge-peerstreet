class AddCoreBasedStatisticalAreaMetropolitanStatisticalAreaUniqueIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :core_based_statistical_area_metropolitan_statistical_areas, [:core_based_statistical_area_id, :metropolitan_statistical_area_id], unique: true, name: 'idx_cbsa_msa_on_cbsa_id_msa_id'
  end
end
