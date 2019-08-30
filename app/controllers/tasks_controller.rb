class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user, only: [:show, :edit, :update, :destroy]
    # def index
    #   if params[:search].nil?
    #     if title_params && status_params
    #       @tasks = mytask_page.wheres(title_params, status_params).includes(:user)
    #     elsif title_params
    #       @tasks = mytask_page.wheretitle(title_params).includes(:user)
    #        binding.pry
    #     elsif status_params
    #       @tasks = mytask_page.wherestatus(status_params).includes(:user)
    #       # binding.pry
    #     elsif label_params
    #       @tasks = Label.find(params[:label_id]).tasks.includes(:user).where(user_id: current_user.id)
    #     end
    #   end

    #   if params[:sort_expired].present?
    #     @tasks = mytask_page.expsorted.includes(:user)
    #   elsif params[:sort_priority].present?
    #     @tasks = mytask_page.priority_order(params[:direction]).includes(:user)
    #   else
    #     @tasks = current_user.tasks.page(params[:page]).sorted.includes(:user)
    #     # redirect_to new_session_path
    #   end
    # end
    
    def index
      if params[:search].nil?
        if title_params.present? && status_params.present?
          @tasks = mytask_page.wheres(title_params, status_params).includes(:user)
        elsif title_params.present?
          @tasks = mytask_page.wheretitle(title_params).includes(:user)
        elsif status_params.present?
          @tasks = mytask_page.wherestatus(status_params).includes(:user)
        # elsif params[:label].blank?
        #   redirect_to tasks_path
        elsif label_params.present?
          @tasks = Label.find(params[:label]).tasks.includes(:user).where(user_id: current_user.id)
        elsif params[:sort_expired].present?
          @tasks = mytask_page.expsorted.includes(:user)
        elsif params[:sort_priority].present?
          @tasks = mytask_page.priority_order(params[:direction]).includes(:user)
        else
          @tasks = current_user.tasks.page(params[:page]).sorted.includes(:user)
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
        params.require(:task).permit(:title, :content, :expiration_out, :status, :priority, label_ids: [])
    end

    def search_params
      params[:task] && params[:task][:search]
    end

    def title_params
      params[:task] && params[:task][:title]
    end

    def status_params
      params[:task] && params[:task][:status]
    end

    def label_params
      params[:task] && params[:task][:label]
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
