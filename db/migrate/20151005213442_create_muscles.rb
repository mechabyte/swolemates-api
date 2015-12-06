class CreateMuscles < ActiveRecord::Migration
  def change
    create_table :muscles do |t|
      t.string :name
      t.text :description
    end
  end
end
