class AddExercisesCountToMuscles < ActiveRecord::Migration

  def self.up

    add_column :muscles, :exercises_count, :integer, :null => false, :default => 0
    Exercise.counter_culture_fix_counts

  end

  def self.down

    remove_column :muscles, :exercises_count

  end

end
