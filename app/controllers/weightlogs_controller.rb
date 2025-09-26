class WeightlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weightlog, only: [:show, :edit, :update, :destroy]

  def index
    @weightlogs = current_user.weightlogs.ordered.page(params[:page]).per(20)
    @metrics = current_user.weight_metrics
    @chart_data = current_user.weight_chart_data
  end

  def show
  end

  def new
    @date = params[:date] ? Date.parse(params[:date]) : Date.current
    @weightlog = Weightlog.find_or_initialize_for_date(current_user, @date)
  end

  def create
    @date = Date.parse(params[:weightlog][:logged_at]) if params[:weightlog][:logged_at].present?
    @weightlog = Weightlog.find_or_initialize_for_date(current_user, @date || Date.current)
    
    if @weightlog.persisted?
      # If record exists, update it
      if @weightlog.update(weightlog_params)
        redirect_to weightlogs_path, notice: 'Weight updated successfully!'
      else
        render :new
      end
    else
      # If new record, create it
      if @weightlog.update(weightlog_params)
        redirect_to weightlogs_path, notice: 'Weight logged successfully!'
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @weightlog.update(weightlog_params)
      redirect_to weightlogs_path, notice: 'Weight updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @weightlog.destroy
    redirect_to weightlogs_path, notice: 'Weight log deleted successfully!'
  end

  private

  def set_weightlog
    @weightlog = current_user.weightlogs.find(params[:id])
  end

  def weightlog_params
    params.require(:weightlog).permit(:weight, :logged_at)
  end
end
