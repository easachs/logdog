class WorkoutTemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout_template, only: [ :show, :edit, :update, :destroy ]

  def index
    @workout_templates = WorkoutTemplate.all.order(:name).page(params[:page]).per(10)
  end

  def show
    @workout_template_exercises = @workout_template.workout_template_exercises.includes(:exercise).order(:order)
  end

  def new
    @workout_template = WorkoutTemplate.new
  end

  def create
    @workout_template = WorkoutTemplate.new(workout_template_params)
    if @workout_template.save
      redirect_to @workout_template, notice: "Workout template was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @workout_template.update(workout_template_params)
      redirect_to @workout_template, notice: "Workout template was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @workout_template.destroy
    redirect_to workout_templates_path, notice: "Workout template was successfully deleted."
  end

  def create_workout
    @workout_template = WorkoutTemplate.find(params[:id])
    @workout = @workout_template.build_workout_for(current_user)

    if @workout.persisted?
      redirect_to @workout, notice: "Workout created from template successfully!"
    else
      redirect_to workout_templates_path, alert: "Failed to create workout from template."
    end
  end

  private

  def set_workout_template
    @workout_template = WorkoutTemplate.find(params[:id])
  end

  def workout_template_params
    params.require(:workout_template).permit(:name, :description)
  end

  def workout_params
    params.permit(:name, :notes, :performed_at, :length)
  end
end
