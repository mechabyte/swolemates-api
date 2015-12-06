class Exercise < ActiveRecord::Base
  belongs_to :muscle, inverse_of: :exercises
  has_many :exercise_steps, inverse_of: :exercise

  counter_culture :muscle

  default_scope { order('name ASC') }
end
