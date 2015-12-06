class UsersController < JSONAPI::ResourceController

	def login
		user = User.find_by(email: params[:email])
		if user = User.authenticate(params[:email], params[:password])
			Rails.logger.debug "Successful login"
			render json: { auth_token: represent_user_with_token(user) }
		else
			Rails.logger.debug "Invalid email or password"
			render json: { error: 'Invalid email or password'}, :status => 401
		end
	end

	private

	def represent_user_with_token(user)
		TokenProvider.issue_token(
          first_name: user.first_name,
          last_name: user.last_name,
          username: user.username,
          user_id: user.id,
          role: user.role
        )
	end

end