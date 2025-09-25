class CreateWorkoutTemplateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :workout_template_exercises do |t|
      t.references :workout_template, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :order, null: false
      t.text :notes

      t.timestamps
    end

    add_index :workout_template_exercises, [ :workout_template_id, :order ]
  end
end
