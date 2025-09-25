class CreateWorkoutSets < ActiveRecord::Migration[8.0]
  def change
    create_table :workout_sets do |t|
      t.references :workout_exercise, null: false, foreign_key: true
      t.integer :set_number
      t.integer :reps
      t.decimal :weight

      t.timestamps
    end
  end
end
