class ExerciseResource < JSONAPI::Resource
	  has_many :exercise_steps, inverse_of: :exercise
	  #belongs_to :muscle, inverse_of: :exercises

  	  attributes :name
end