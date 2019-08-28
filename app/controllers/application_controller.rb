class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :user_logged_in?
  # 例外処理
  def user_logged_in?
    if session[:user_id]
      begin
        @current_user = User.find_by(id: session[:user_id])
      rescue ActiveRecord::RecordNotFound
        reset_user_session
      end
    end
    return if @current_user
      # @current_userが取得できなかった場合はログイン画面にリダイレクト
      # flash[:referer] = request.fullpath
      flash[:notice] = 'ログインしてください'
      redirect_to new_session_path
  end
  def reset_user_session
    session[:user_id] = nil
    @current_user = nil
  end
  # before_action :basic_authentication
  # #protect_from_forgery with: :exception

  # private

  # def basic_authentication
  #   authenticate_or_request_with_http_basic do |name, password|
  #     name == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
  #   end
  # end
end

  