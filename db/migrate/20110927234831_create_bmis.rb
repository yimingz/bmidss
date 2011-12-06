class CreateBmis < ActiveRecord::Migration
  def change
    create_table :bmis do |t|
      t.integer :age
      t.string :race
      t.string :gender
      t.string :activity_level
      t.integer :weight_lb
      t.integer :weight_kg
      t.integer :height_inch
      t.integer :height_feet
      t.integer :height_cm
      t.integer :year

      t.timestamps
    end
  end
end
