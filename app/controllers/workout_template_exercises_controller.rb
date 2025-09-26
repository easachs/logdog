class WorkoutTemplateExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout_template
  before_action :set_workout_template_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @workout_template_exercises = @workout_template.workout_template_exercises.order(:order)
  end

  def show
  end

  def new
    @workout_template_exercise = @workout_template.workout_template_exercises.build
    @exercises = Exercise.all.order(:name)
  end

  def create
    @workout_template_exercise = @workout_template.workout_template_exercises.build(workout_template_exercise_params)
    
    if @workout_template_exercise.save
      redirect_to workout_template_workout_template_exercises_path(@workout_template), 
                  notice: 'Exercise added to template successfully!'
    else
      @exercises = Exercise.all.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @exercises = Exercise.all.order(:name)
  end

  def update
    if @workout_template_exercise.update(workout_template_exercise_params)
      redirect_to workout_template_workout_template_exercises_path(@workout_template), 
                  notice: 'Template exercise updated successfully!'
    else
      @exercises = Exercise.all.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout_template_exercise.destroy
    redirect_to workout_template_workout_template_exercises_path(@workout_template), 
                notice: 'Exercise removed from template successfully!'
  end

  private

  def set_workout_template
    @workout_template = WorkoutTemplate.find(params[:workout_template_id])
  end

  def set_workout_template_exercise
    @workout_template_exercise = @workout_template.workout_template_exercises.find(params[:id])
  end

  def workout_template_exercise_params
    params.require(:workout_template_exercise).permit(:exercise_id, :order, :notes)
  end
end
