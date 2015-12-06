class ExerciseStepResource < JSONAPI::Resource
	attribute :desc

	def desc
		@model.description
	end
end
