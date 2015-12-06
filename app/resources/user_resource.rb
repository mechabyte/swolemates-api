class UserResource < JSONAPI::Resource
  attributes :first_name, :last_name, :username, :email

  class NotAuthorizedError < StandardError; end
end