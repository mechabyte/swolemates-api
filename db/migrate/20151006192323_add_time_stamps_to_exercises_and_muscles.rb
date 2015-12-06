class AddTimeStampsToExercisesAndMuscles < ActiveRecord::Migration
  def change
    add_timestamps(:exercises)
    add_timestamps(:muscles)
  end
end
