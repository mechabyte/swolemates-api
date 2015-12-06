class AddCounterCacheToMuscles < ActiveRecord::Migration
  def change
    add_column :muscles, :exercises_count, :integer, :default => 0
  end
end
