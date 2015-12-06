class ApplicationController < ActionController::API
  include ActionController::RespondWith
  respond_to :json

  before_action :authenticate!

  def validate_token!
    begin
      TokenProvider.valid?(token)
    rescue
      error('Unauthorized', 401)
    end
  end

  def authenticate!
    begin
      payload, header = TokenProvider.valid?(token)
      @current_user = User.find_by(id: payload['user_id'])
      Rails.logger.debug "#{@current_user.first_name} is accessing the API"
    rescue
      error!('Unauthorized', 401)
    end
  end

  def current_user
    @current_user ||= authenticate!
  end

  def token
    request.headers['Authorization'].split(' ').last
  end
end
