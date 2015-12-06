class RemoveCounterCacheFromMuscles < ActiveRecord::Migration
  def change
  	remove_column :muscles, :exercises_count, :integer, :default => 0
  end
end
