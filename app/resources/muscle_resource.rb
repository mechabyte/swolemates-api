class MuscleResource < JSONAPI::Resource
	  has_many :exercises, inverse_of: :muscle

      attribute :name
      attribute :exercise_count

	  def exercise_count
	    @model.exercises_count
	  end
end