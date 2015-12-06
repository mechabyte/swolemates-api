module API
  module V1

    class UserEntity < Grape::Entity
      expose :id
      expose :username
    end

    class UserForAuth < API::V1::UserEntity
      #expose :is_admin
      #expose :id
      expose :first_name
      expose :last_name
      #expose :username
      expose :email
      expose :auth_token
      #unexpose :id
      #unexpose :username

      private

      #def is_admin
      #  object.role == "admin"
      #end

      def auth_token
        TokenProvider.issue_token(
          first_name: object.first_name,
          last_name: object.last_name,
          username: object.username,
          user_id: object.id,
          role: object.role
        )
      end
    end
  	
  	class Users < Grape::API

      helpers do
        def represent_user_with_token(user)
          present user, with: API::V1::UserForAuth
        end
      end

      resource :users do
        desc "Register a new user"
        params do
          requires :first_name
          requires :last_name
          requires :email
          requires :username
          requires :password
        end
        post do
          user = User.new(declared(params).to_h)
          user.save!
          represent_user_with_token(user)
        end

        desc "Login an existing user"
        params do
          requires :email
          requires :password
        end
        post "login" do
          user = User.find_by(email: params[:email])
          if user = User.authenticate(params[:email], params[:password])
          	Rails.logger.debug "Successful login"
            represent_user_with_token(user)
          else
          	Rails.logger.debug "Invalid email or password"
            error!("Invalid email or password", 401)
          end
        end

        get do
          authenticate!
          present :data, User.all, with: API::V1::UserEntity
        end
      end

    end
  end
end