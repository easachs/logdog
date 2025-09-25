class WorkoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout, only: [ :show, :edit, :update, :destroy ]

  def index
    @workouts = current_user.workouts.order(performed_at: :desc)
                            .page(params[:page]).per(2)
  end

  def show
  end

  def new
    @workout = current_user.workouts.new
  end

  def create
    @workout = current_user.workouts.new(workout_params)
    @workout.user = current_user
    @workout.save
    redirect_to workout_path(@workout)
  end

  def edit
  end

  def update
    @workout.update(workout_params)
    redirect_to workout_path(@workout)
  end

  def destroy
    @workout.destroy
    redirect_to workouts_path
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :notes, :performed_at, :length)
  end
end
