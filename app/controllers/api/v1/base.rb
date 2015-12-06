module API
  module V1
    class Base < Grape::API
      helpers API::V1::Helpers
      version 'v1', using: :path, vendor: 'swolemates', cascade: false

      rescue_from ActiveRecord::RecordNotFound do |e|
        error_response(message: e.message, status: 404)
      end

      rescue_from :all do |e|
        if Rails.env.development?
          raise e 
        else
          Rails.logger.error(e)
        end
      end


      # Entities
      mount API::V1::Users
      mount API::V1::Exercises
      mount API::V1::Muscles

    end
  end
end