class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        @tasks = Task.all.order(created_at: "DESC")
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
        params.require(:task).permit(:title, :content)
    end

    def set_task
        @task = Task.find(params[:id])
    end
end
