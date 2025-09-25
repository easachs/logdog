class WorkoutExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout
  before_action :set_workout_exercise, only: [ :show, :edit, :update, :destroy ]

  def index
    @workout_exercises = @workout.workout_exercises.includes(:exercise).order(:order)
  end

  def show
  end

  def new
    @workout_exercise = @workout.workout_exercises.build
    @exercises = Exercise.all.order(:name)
  end

  def create
    @workout_exercise = @workout.workout_exercises.build(workout_exercise_params)
    @workout_exercise.order = @workout.workout_exercises.count + 1

    if @workout_exercise.save
      redirect_to workout_path(@workout), notice: "Exercise added to workout."
    else
      @exercises = Exercise.all.order(:name)
      render :new
    end
  end

  def edit
    @exercises = Exercise.all.order(:name)
  end

  def update
    if @workout_exercise.update(workout_exercise_params)
      redirect_to workout_path(@workout), notice: "Workout exercise updated."
    else
      @exercises = Exercise.all.order(:name)
      render :edit
    end
  end

  def destroy
    @workout_exercise.destroy
    redirect_to workout_path(@workout), notice: "Exercise removed from workout."
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def set_workout_exercise
    @workout_exercise = @workout.workout_exercises.find(params[:id])
  end

  def workout_exercise_params
    params.require(:workout_exercise).permit(:exercise_id, :notes, :order)
  end
end
