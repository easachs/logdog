class ExercisesController < ApplicationController
  before_action :authenticate_user!

  def show
    @exercise = WorkoutExercise.find(params[:id])
  end

  def create
    @exercise = WorkoutExercise.new(exercise_params)
    @exercise.save
    redirect_to workout_path(@exercise.workout)
  end

  def edit
    @exercise = WorkoutExercise.find(params[:id])
  end

  def update
    @exercise = WorkoutExercise.find(params[:id])
    @exercise.update(workout_exercise_params)
    redirect_to workout_path(@exercise.workout)
  end

  def destroy
    @exercise = WorkoutExercise.find(params[:id])
    @exercise.destroy
    redirect_to workout_path(@exercise.workout)
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def exercise_params
    params.require(:exercise).permit(:sets, :reps, :weight, :notes)
  end
end
