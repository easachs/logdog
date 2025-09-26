require 'rails_helper'

RSpec.describe WorkoutTemplate, type: :model do
  describe 'associations' do
    it { should have_many(:workout_template_exercises).dependent(:destroy) }
    it { should have_many(:exercises).through(:workout_template_exercises) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe '#build_workout_for' do
    let(:user) { create(:user) }
    let(:template) { create(:workout_template) }
    let(:exercise1) { create(:exercise) }
    let(:exercise2) { create(:exercise) }
    let!(:template_exercise1) { create(:workout_template_exercise, workout_template: template, exercise: exercise1, order: 1, notes: 'Template notes 1') }
    let!(:template_exercise2) { create(:workout_template_exercise, workout_template: template, exercise: exercise2, order: 2, notes: 'Template notes 2') }

    it 'creates a workout for the user' do
      expect {
        template.build_workout_for(user)
      }.to change(Workout, :count).by(1)
    end

    it 'creates workout exercises from template exercises' do
      workout = template.build_workout_for(user)
      expect(workout.workout_exercises.count).to eq(2)
    end

    it 'preserves order and notes from template' do
      workout = template.build_workout_for(user)
      workout_exercise = workout.workout_exercises.find_by(exercise: exercise1)
      expect(workout_exercise.order).to eq(1)
      expect(workout_exercise.notes).to eq('Template notes 1')
    end

    it 'sets workout name with template name and date' do
      workout = template.build_workout_for(user)
      expect(workout.name).to include(template.name)
      expect(workout.name).to include(Date.current.strftime('%B %d, %Y'))
    end

    it 'sets performed_at to current time' do
      workout = template.build_workout_for(user)
      expect(workout.performed_at).to be_within(1.second).of(Time.current)
    end

    it 'preserves exercise order when creating workout from template' do
      template = create(:workout_template, name: 'Ordered Template')
      exercise1 = create(:exercise, name: 'First Exercise')
      exercise2 = create(:exercise, name: 'Second Exercise')
      exercise3 = create(:exercise, name: 'Third Exercise')
      
      create(:workout_template_exercise, workout_template: template, exercise: exercise1, order: 1)
      create(:workout_template_exercise, workout_template: template, exercise: exercise2, order: 2)
      create(:workout_template_exercise, workout_template: template, exercise: exercise3, order: 3)
      
      workout = template.build_workout_for(user)
      exercises = workout.workout_exercises.order(:order)
      expect(exercises.first.exercise.name).to eq('First Exercise')
      expect(exercises.second.exercise.name).to eq('Second Exercise')
      expect(exercises.third.exercise.name).to eq('Third Exercise')
    end

    it 'preserves notes when creating workout from template' do
      template = create(:workout_template, name: 'Noted Template')
      exercise = create(:exercise, name: 'Noted Exercise')
      create(:workout_template_exercise, workout_template: template, exercise: exercise, order: 1, notes: 'Template note')
      
      workout = template.build_workout_for(user)
      workout_exercise = workout.workout_exercises.first
      expect(workout_exercise.notes).to eq('Template note')
    end
  end

  describe 'data integrity' do
    it 'maintains referential integrity when template is deleted' do
      template = create(:workout_template)
      exercise = create(:exercise)
      template_exercise = create(:workout_template_exercise, workout_template: template, exercise: exercise)
      
      # Template deletion should cascade delete template_exercise
      expect {
        template.destroy
      }.to change(WorkoutTemplateExercise, :count).by(-1)
      expect { template_exercise.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
