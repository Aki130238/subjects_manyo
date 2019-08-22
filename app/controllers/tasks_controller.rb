class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user, only: [:show, :edit, :update, :destroy]

    def index
      if logged_in?
        if params[:task] && params[:task][:search] && params[:task][:title] && params[:task][:status]
          @tasks = Task.page(params[:page]).wheres(params[:task][:title], params[:task][:status])
        elsif params[:task] && params[:task][:search] && params[:task][:title]
          @tasks = Task.page(params[:page]).wheretitle(params[:task][:title])
        elsif params[:task] && params[:task][:search] && params[:task][:status]
          @tasks = Task.page(params[:page]).wherestatus(params[:task][:status])
        elsif params[:sort_expired]
          @tasks = Task.page(params[:page]).expsorted
        elsif params[:sort_priority]
          @tasks = Task.page(params[:page]).priority_order(params[:direction])
        elsif
          @tasks = Task.page(params[:page]).sorted
        else
          @tasks = Task.page(params[:page])
        end
      else
        redirect_to new_session_path
      end
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
        params.require(:task).permit(:title, :content, :expiration_out, :status, :priority)
    end

    def set_task
        @task = Task.find(params[:id])
    end

    def authenticate_user
      unless current_user.id == @user.id
        flash[:notice] = "ログインが必要"
        redirect_to new_session_path, notice:"ログインが必要です"
      end
    end

end
