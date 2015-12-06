class CreateExerciseSteps < ActiveRecord::Migration
  def change
    create_table :exercise_steps do |t|
      t.text :description
      t.integer :row_order
      t.references :exercise, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
