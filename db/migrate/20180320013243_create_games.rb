class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :word, limit: 20, null: false
      t.string :guesses
      t.integer :lives, default: 5

      t.timestamps
    end
  end
end
