JSONAPI.configure do |config|
  config.exception_class_whitelist = [UserResource::NotAuthorizedError]
end