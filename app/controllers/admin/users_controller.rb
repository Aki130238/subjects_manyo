class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.includes(:tasks)
    # @tasks = Task.select(:id, :titile, :content, :created_at)
  end

  def new
    @user = User.new
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

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "userを編集しました！"
    else
      render 'edit', notice: "失敗しました"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"userを削除しました！"
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_user
    unless current_user.id == @user.id
      flash[:notice] = "ログインが必要"
      redirect_to users_path, notice:"ログインが必要です"
    end
  end


end
