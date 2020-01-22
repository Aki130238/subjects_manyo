class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user, only: [:show, :edit, :update, :destroy]
    
    def index
      # if params[:search].nil?
      #   if params[:sort_priority].present?
      #     @tasks = current_user.tasks.priority_order(params[:direction])
      #   elsif params[:sort_expired].present?
      #     @tasks = current_user.tasks.expsorted
      #   else
      #     @tasks = current_user.tasks
      #   end
      # else
      #   if title_params.present? && status_params.blank? && label_params.blank?
      #     @tasks = current_user.tasks.wheretitle(title_params)
      #   elsif title_params.present? && status_params.present? && label_params.blank?
      #     @tasks = current_user.tasks.wheretitle(title_params).wherestatus(status_params)
      #   elsif title_params.present? && status_params.present? && label_params.present?
      #     @tasks = Label.find(params[:label]).tasks.wheretitle(title_params).wherestatus(status_params).includes(:user).where(user_id: current_user.id)
      #   elsif title_params.present? && status_params.blank? && label_params.present?
      #     @tasks = Label.find(params[:label]).tasks.wheretitle(title_params).includes(:user).where(user_id: current_user.id)
      #   elsif title_params.blank? && status_params.present? && label_params.blank?
      #     @tasks = current_user.tasks.wherestatus(status_params)
      #   elsif title_params.blank? && status_params.present? && label_params.present?
      #     @tasks = Label.find(params[:label]).tasks.wherestatus(status_params).includes(:user).where(user_id: current_user.id)
      #   elsif title_params.blank? && status_params.blank? && label_params.present?
      #     @tasks = Label.find(params[:label]).tasks.includes(:user).where(user_id: current_user.id)
      #   else
      #     @tasks = current_user.tasks
      #   end
      # end
      @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(params_task)
        @task.user_id = current_user.id
        if @task.save
          redirect_to tasks_path, notice: "タスクを作成しました！"
        else
          render :new, notice: "タスクを作成に失敗しました"
        end
    end

    def show
    end

    def edit
    end

    def update
        @task = @task.update(params_task)
        redirect_to tasks_path, notice: "タスクを編集しました！"
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice: "タスクを削除しました！"
    end

    private

    def params_task
        params.require(:task).permit(:title, :content, :expiration_out, :status, :priority, label_ids: [])
    end

    def search_params
      params[:search]
    end

    def title_params
      params[:title]
    end

    def status_params
      params[:status]
    end

    def label_params
      params[:label]
    end

    def mytask_page
      current_user.tasks.page(params[:page])
    end

    def set_task
        @task = Task.find(params[:id])
    end

    def authenticate_user
      unless current_user.id == @task.user_id
        flash[:notice] = "ログインが必要"
        redirect_to new_session_path, notice:"ログインが必要です"
      end
    end

end
