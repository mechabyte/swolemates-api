module API
  class Base < Grape::API
  	format :json

  	rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!({ messages: e.full_messages }, 400)
    end
    
    mount API::V1::Base
  end
end