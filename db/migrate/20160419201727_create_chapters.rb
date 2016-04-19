class CreateChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :hour
      t.integer :number

      t.timestamps
    end
  end
end
