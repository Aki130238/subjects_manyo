class Admin::UsersController < ApplicationController
  # before_action :nil_user, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user?
  
  def index
    @users = User.all.includes(:tasks)
    # @tasks = Task.select(:id, :titile, :content, :created_at)
    @user = User.where(id: params[:admin])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "userを作成しました！"
      # redirect_to users_path, notice: "userを作成しました！"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if User.where(admin: true).count == 1 && current_user.id == @user.id
      @user.update(admin_params)
      redirect_to admin_users_path, notice: "最後のadminを削除しないで！"
    elsif User.where(admin: true).count > 1 && current_user.id == @user.id
      @user.update(user_params)
      redirect_to admin_users_path, notice: "userを編集しました！"
    elsif User.where(admin: true).count >= 1
      @user.update(user_params)
      redirect_to admin_users_path, notice: "userを編集しました！"
    else
      render 'edit', notice: "失敗しました"
    end
  end

  def destroy
    if User.where(admin: true).count == 1 && current_user.id == @user.id
      redirect_to admin_users_path, notice:"最後のadminはあなたです！"
    elsif User.where(admin: true).count > 1 && current_user.id == @user.id
      @user.destroy
      redirect_to admin_users_path, notice:"userを削除しました"
    else
      @user.destroy
      redirect_to admin_users_path, notice:"userを削除しました"
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user?
    unless current_user.admin?
      flash[:notice] = "権限がありません"
      redirect_to tasks_path, notice:"権限が必要です"
    end
  end

  def nil_user
    if current_user == nil
      redirect_to tasks_path, notice:"ログインが必要です"
    end
  end

end
