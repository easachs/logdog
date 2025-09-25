class WorkoutSetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout
  before_action :set_workout_exercise
  before_action :set_workout_set, only: [ :show, :edit, :update, :destroy ]

  def index
    @workout_sets = @workout_exercise.workout_sets.order(:set_number)
  end

  def show
  end

  def new
    @workout_set = @workout_exercise.workout_sets.build
    @workout_set.set_number = @workout_exercise.workout_sets.count + 1
  end

  def create
    @workout_set = @workout_exercise.workout_sets.build(workout_set_params)

    if @workout_set.save
      redirect_to workout_workout_exercise_path(@workout, @workout_exercise),
                  notice: "Set added to exercise."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @workout_set.update(workout_set_params)
      redirect_to workout_workout_exercise_path(@workout, @workout_exercise),
                  notice: "Set updated."
    else
      render :edit
    end
  end

  def destroy
    @workout_set.destroy
    redirect_to workout_workout_exercise_path(@workout, @workout_exercise),
                notice: "Set removed."
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def set_workout_exercise
    @workout_exercise = @workout.workout_exercises.find(params[:workout_exercise_id])
  end

  def set_workout_set
    @workout_set = @workout_exercise.workout_sets.find(params[:id])
  end

  def workout_set_params
    params.require(:workout_set).permit(:set_number, :reps, :weight)
  end
end
