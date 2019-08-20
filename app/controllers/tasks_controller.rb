class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        
        if params[:task] && params[:task][:search] && params[:task][:title] && params[:task][:status]
          @tasks = Task.wheres(params[:task][:title], params[:task][:status])
        elsif params[:task] && params[:task][:search] && params[:task][:title]
          @tasks = Task.wheretitle(params[:task][:title])
        elsif params[:task] && params[:task][:search] && params[:task][:status]
          @tasks = Task.wherestatus(params[:task][:status])
        elsif params[:sort_expired]
          @tasks = Task.all.expsorted
        elsif
          @tasks = Task.all.sorted
        else
          @tasks = Task.all
        end
        
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(params_task)
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
        params.require(:task).permit(:title, :content, :expiration_out, :status)
    end

    def set_task
        @task = Task.find(params[:id])
    end
end
