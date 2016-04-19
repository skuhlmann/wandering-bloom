class CreateSentences < ActiveRecord::Migration[5.0]
  def change
    create_table :sentences do |t|
      t.string :text

      t.timestamps
    end

    add_reference :sentences, :chapter, index: true
  end
end
