class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to tasks_path
    @users = User.all
  end

  def new
    @user = User.new
    if logged_in?
      redirect_to tasks_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: "userを作成しました！"
      # redirect_to users_path, notice: "userを作成しました！"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def new_user
    @user = User.new
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_user
    unless current_user.id == @user.id
      flash[:notice] = "ログインが必要"
      redirect_to tasks_path, notice:"ログインが必要です"
    end
  end

end
