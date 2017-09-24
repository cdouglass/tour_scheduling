class ApplicationController < ActionController::API
  protect_from_forgery unlesss: -> { request.format.json? }
end
