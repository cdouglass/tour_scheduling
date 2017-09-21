class ApplicationController < ActionController::Base
  protect_from_forgery unlesss: -> { request.format.json? }
end
