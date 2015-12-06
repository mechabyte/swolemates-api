module API
  module V1
    class ExerciseEntity < Grape::Entity
      expose :id
      expose :name
      expose :muscle_for_exercise, if: { include_muscle: true } 

      private

      def muscle_for_exercise
        { muscle_id: object.muscle.id, muscle_name: object.muscle.name }
      end
    end

    class ExerciseStepEntity < Grape::Entity
      expose :id
      expose :description
    end

    class ExerciseEntityDetailed < API::V1::ExerciseEntity
      #expose :muscle_for_exercise, if: { hide_muscle: !true } 
      expose :steps, with: API::V1::ExerciseStepEntity

      private

      def steps
        object.exercise_steps.order(:row_order)
      end
    end

    class ExerciseEntityAllInfo < API::V1::ExerciseEntityDetailed
      unexpose :muscle_for_exercise
    end

    class Exercises < Grape::API
      resource :exercises do

        desc 'Return a list of all exercises'
        get do
          exercises = Exercise.includes(:muscle).all.order(:name)
          present :exercises, exercises, with: API::V1::ExerciseEntity, include_muscle: true
        end
        
        desc 'Return a detailed overview of an exercise given the ID'
        params do
          requires :id, type: Integer, desc: 'Exercise ID'
        end
        route_param :id do
          get do
            exercise = Exercise.find(params[:id])
            present :exercise, exercise, with: API::V1::ExerciseEntityDetailed
          end
        end

      end
    end
  end
end