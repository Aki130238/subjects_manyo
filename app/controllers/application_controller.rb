class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper
  # before_action :basic_authentication
  # #protect_from_forgery with: :exception

  # private

  # def basic_authentication
  #   authenticate_or_request_with_http_basic do |name, password|
  #     name == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
  #   end
  # end
end
