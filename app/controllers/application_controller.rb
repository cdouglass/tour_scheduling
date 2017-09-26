class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  after_action :set_access_control_headers

  private

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = "http://localhost:3333"
    headers['Access-Control-Allow-Headers'] = "*"
    headers['Access-Control-Request-Method'] = '*'
  end
end
