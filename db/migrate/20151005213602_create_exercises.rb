class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.text :description
      t.references :muscle, index: true, foreign_key: true
    end
  end
end
