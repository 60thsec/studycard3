class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :front
      t.string :back
      t.datetime :due
      t.references :deck, index: true, foreign_key: true
      t.integer :interval
      t.float :efactor
      t.integer :repetition
      t.string :status

      t.timestamps null: false
    end
  end
end
