module API
  module V1
    class MuscleEntity < Grape::Entity
      expose :id
      expose :name
      expose :exercises_count
    end

    class MuscleEntityForAppInit < Grape::Entity
      expose :id
      expose :name
      expose :exercises_count
      expose :exercises, with: API::V1::ExerciseEntityDetailed
    end

    class MuscleEntityDetailed < API::V1::MuscleEntity
      expose :exercises, using: API::V1::ExerciseEntity
    end

    class MuscleEntityAllInfo < Grape::Entity
      expose :id
      expose :name
      expose :exercises_count

      expose :exercises, with: API::V1::ExerciseEntityAllInfo
    end

    class Muscles < Grape::API
      resource :muscles do

        desc 'Return a list of all muscles'
        get do
            authenticate!
            muscles = Muscle.all
            present muscles, with: API::V1::MuscleEntity
        end

        desc 'Return a list of all muscles and exercises'
        get 'for_app_init' do
          muscles = Muscle.all
          present muscles, with: API::V1::MuscleEntityForAppInit
        end

        desc 'Return exercises for a given muscle'
        params do
          requires :id, type: Integer, desc: 'Muscle ID'
        end
        route_param :id do
          get do
              muscle = Muscle.find(params[:id])
              present muscle, with: API::V1::MuscleEntityAllInfo
              #present :exercises, muscle.exercises, with: API::V1::ExerciseEntity
          end
        end

      end

      get 'all' do
        muscles = Muscle.all
        present muscles, with: API::V1::MuscleEntityAllInfo
      end
    end
  end
end