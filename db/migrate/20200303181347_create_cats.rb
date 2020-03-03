class CreateCats < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.date :birth_date, null: false
      t.string :color, null: false
      t.string :name
      t.string :sex, null: false, limit: 2
      t.text :description
      t.timestamps
    end
  end
end
