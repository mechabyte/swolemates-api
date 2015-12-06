class ExerciseStep < ActiveRecord::Base
  belongs_to :exercise, inverse_of: :exercise_steps

  include RankedModel
  ranks :row_order
end
